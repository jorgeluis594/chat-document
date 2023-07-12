class Document < ApplicationRecord
  extend FriendlyId
  friendly_id :file_name, use: :slugged

  has_one_attached :file
  # after_create_commit :index_file!

  validate { errors.add(:file, 'must be present') unless file.attached? }
  validate { errors.add(:file, 'must be a pdf') unless file.content_type == 'application/pdf' }

  def index_file
    if VECTOR_SEARCH_CLIENT.add_texts(texts: chunks, namespace: slug)
      update(indexed: true)
    end
  end

  def ask(question)
    VECTOR_SEARCH_CLIENT.ask(question: question, namespace: slug)
  end

  private

  def file_name
    file.filename.to_s
  end

  def chunks
    file_loader.chunks(chunk_size: 500, chunk_overlap: 50).map { |chunk_data| chunk_data[:text] }
  end

  def file_loader
    Langchain::Loader.new(file_url).load
  end

  def file_url
    Rails.application.routes.url_helpers.url_for(file)
  end

end

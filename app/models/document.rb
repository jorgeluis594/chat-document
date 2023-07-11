class Document < ApplicationRecord
  extend FriendlyId
  friendly_id :file_name, use: :slugged

  has_one_attached :file
  # after_create_commit :index_file!

  validate { errors.add(:file, 'must be present') unless file.attached? }
  validate { errors.add(:file, 'must be a pdf') unless file.content_type == 'application/pdf' }

  private

  def file_name
    file.filename.to_s
  end

  def index_file!
    VECTOR_SEARCH_CLIENT.add_texts(texts: file_loader.chunks(chunk_size: 500, chunk_overlap: 50), namespace: slug)
  end

  def file_loader
    Langchain::Loader.new(file_url).load
  end

  def file_url
    Rails.application.routes.url_helpers.url_for(file)
  end

end

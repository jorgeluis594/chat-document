class Document < ApplicationRecord
  extend FriendlyId
  friendly_id :file, use: :slugged

  has_one_attached :file
  after_create_commit :index_file!

  validates :file, attached: true, content_type: %w[application/pdf]


  private

  def index_file!
    VECTOR_SEARCH_CLIENT.add_texts(texts: file_loader.load.value)
  end

  def file_loader
    Langchain::Loader.new(file_url)
  end

  def client
    @client ||= Langchain::Vectorsearch::Pinecone.new(
      environment: ENV['PINECONE_ENVIRONMENT'],
      api_key: ENV['PINECONE_API_KEY'],
      index_name: ENV['PINECONE_INDEX_NAME'],
      llm: OPENAI_CLIENT
    )
  end

  def file_url
    Rails.application.routes.url_helpers.url_for(file)
  end

end

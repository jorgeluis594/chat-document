OPENAI_CLIENT = Langchain::LLM::OpenAI.new(api_key: ENV['OPENAI_API_KEY'])
VECTOR_SEARCH_CLIENT = Langchain::Vectorsearch::Pinecone.new(
  environment: ENV['PINECONE_ENVIRONMENT'],
  api_key: ENV['PINECONE_API_KEY'],
  index_name: ENV['PINECONE_INDEX_NAME'],
  llm: OPENAI_CLIENT
)

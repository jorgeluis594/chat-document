class Document < ApplicationRecord
  has_one_attached :file

  private

  def loader
    @loader ||= Langchain::Loader.load(file_path)
  end

  def file_path
    if ActiveStorage::Blob.service.class.name.include?('DiskService')
      ActiveStorage::Blob.service.path_for(file.key)
    end
  end
end

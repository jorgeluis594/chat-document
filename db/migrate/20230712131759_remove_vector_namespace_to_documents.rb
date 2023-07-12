class RemoveVectorNamespaceToDocuments < ActiveRecord::Migration[7.0]
  def change
    remove_column :documents, :vector_namespace, :string
  end
end

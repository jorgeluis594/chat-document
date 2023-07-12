class AddIndexedToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :indexed, :boolean, default: false
  end
end

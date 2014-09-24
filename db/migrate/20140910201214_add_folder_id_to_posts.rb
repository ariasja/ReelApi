class AddFolderIdToPosts < ActiveRecord::Migration
  def change

    add_column :posts, :folder_id, :integer
    add_index :posts, :folder_id
  
  ]end
end

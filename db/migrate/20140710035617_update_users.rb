class UpdateUsers < ActiveRecord::Migration
  def change
    add_column :users, :device_token, :string, null: false
    add_column :users, :name, :string, null: false
    add_column :users, :email, :string, null: false, unique: true
    add_column :users, :bio, :string
  end
end

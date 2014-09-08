class AddPasswordAndUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :password, :string
    add_column :users, :password_confirmation, :string
    remove_column :users, :device_token

  end
end

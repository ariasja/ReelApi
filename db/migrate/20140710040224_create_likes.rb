class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false
    end
    add_index :likes, :post_id
    add_index :likes, :user_id
  end
end

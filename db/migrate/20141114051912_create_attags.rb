class CreateAttags < ActiveRecord::Migration
  def change
    create_table :attags do |t|
      t.integer :post_id
      t.integer :tagged_user_id
      t.integer :tagging_user_id
    end
    add_index :attags, :post_id
    add_index :attags, :tagged_user_id
    add_index :attags, :tagging_user_id
  end
end

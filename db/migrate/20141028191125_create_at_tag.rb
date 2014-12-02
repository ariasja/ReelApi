class CreateAtTag < ActiveRecord::Migration
  def change
    create_table :at_tags do |t|
      t.integer :post_id
      t.integer :tagged_user_id
      t.integer :tagging_user_id
    end
  end
end

class AddDetailsToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :post_id, :integer
    add_column :hashtags, :tagging_user_id, :integer
  end
end

class AddPostIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :post_id, :integer
    add_index :videos, :post_id
  end

end

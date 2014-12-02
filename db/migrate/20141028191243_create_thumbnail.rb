class CreateThumbnail < ActiveRecord::Migration
  def change
    create_table :thumbnails do |t|
      t.integer :video_id
    end
  end
end

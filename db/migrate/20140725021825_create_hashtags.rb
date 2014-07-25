class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :tag
    end
    add_index :hashtags, :tag
  end
end

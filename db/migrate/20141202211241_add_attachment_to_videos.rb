class AddAttachmentToVideos < ActiveRecord::Migration
  def self.up
    add_attachment :videos, :video
  end

  def self.down
    remove_attachment :videos, :video
  end
end


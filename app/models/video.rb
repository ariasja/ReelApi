class Video < ActiveRecord::Base
  has_attached_file :video, :styles => {
    :mobile => {:geometry => "300x300", :format => 'mp4', :streaming => true}
  }, :processors => [:ffmpeg, :qtfaststart]
  do_not_validate_attachment_file_type :video

  def video_url
    video.url
  end

end

class Api::V1::VideosController < ApiController
  def create
    @video = Video.create(video_params)
  end

  def index
  end

  def show
    @video = Video.where("post_id = ?", params[:post_id])
    render :json => @video.to_json(:methods => [:video_url])
  end

  def destroy
  end

  private

    def video_params
    {
      video: params[:video],
      post_id: params[:post_id]
    }
    end
end

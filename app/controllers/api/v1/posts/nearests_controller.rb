class Api::V1::Posts::NearestsController < ApiController
  
  def index
    @posts = Post.near([params[:geo_lat], params[:geo_long]], params[:radius], units: :km)
  end

end
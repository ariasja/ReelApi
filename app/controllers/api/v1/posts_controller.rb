class Api::V1::PostsController < ApiController

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.where("user_id = ?", params[:user_id]).reverse_order
  end

  def hashtags_index_by_tag 
    @hashtags = Hashtag.where("tag = ?", params[:tag]).reverse_order
    @posts = []
    for hashtag in @hashtags do
      @posts += Post.where("id = ?", hashtag[:post_id])
    end
  end
    
  def hashtags_index_by_tag_and_by_user
    @hashtags = Hashtag.where("tag = ? AND tagging_user_id = ?", params[:tag], params[:user_id]).reverse_order
    @posts = []
    for hashtag in @hashtags do
      @posts += Post.where("id = ?", hashtag[:post_id])
    end
  end

  def attags_index_by_tagging_user
  end

  def attags_index_by_tagged_user
  
  end
      
  def create
    @post = Post.new(post_params)
    if @post.save
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @post.errors.full_messages
      }, status: 422
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @post.errors.full_messages
      }, status: 422
    end
  end

private

  def post_params
    {
      geo_lat: params[:geo_lat],
      geo_long: params[:geo_long],
      caption: params[:caption],
      user_id: params[:user_id],
      folder_id: params[:folder_id]
    }
  end

  def user
    User.find_by(device_token: device_token)
  end

  def device_token
    params[:user].try(:[], :device_token)
  end

end

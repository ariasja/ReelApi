class Api::V1::LikesController < ApiController

  def create
    @like = Like.new(like_params)
    if @like.save
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @like.errors.full_messages
      }, status: 422
    end
  end

  def index
    @likes = Like.where("post_id = ?", params[:post_id])
  end

private
  
  def like_params
    {
      user: User.find_by_id(params[:user_id]),
      post: Post.find_by_id(params[:post_id])
    }
  end

end
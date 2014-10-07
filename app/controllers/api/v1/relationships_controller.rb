class Api::V1::RelationshipsController < ApiController

  def create
    @followed = User.find(params[:followed_id])
    @follower = User.find(params[:follower_id])
    @follower.follow!(@followed)
    render json:{
      follower_id: :follower_id,
      followed_id: :followed_id,
      message: 'Relationship Created'
      }, status: 200
  end

  def destroy
    @relationship = Relationship.find_by(follower_id: params[:follower_id], followed_id: params[:followed_id])
    puts @relationship
    @follower = User.find(@relationship.follower_id)
    @followed = User.find(@relationship.followed_id)
    @follower.unfollow!(@followed)
    render json:{id: @relationship.id,
      follower_id: :follower_id,
      followed_id: :followed_id,
      message: 'Relationship Destroyed'
      }, status: 200
  end

  def show
    relationship = Relationship.find_by(follower_id: params[:follower_id], followed_id: params[:followed_id])
    if !relationship
      render json: {id: '',
                    follower_id: '',
                    followed_id: '',
                    message: 'Relationship Does Not Exist'
                    }, status: 200
    else
      render json: {id: relationship.id,
        followed_id: relationship.follower_id,
        followed_id: relationship.followed_id,
        message: 'Relationship Exists'
        }, status: 200
    end
  end

private

  def relationship_params
    {
      followed_id: params[:followed_id],
      follower_id: params[:follower_id]
    }
  end
end
class Api::V1::UsersController < ApiController
  
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {
        id: @user.id
      }, status: 200
    else
      render json: {
        message: 'Validation Failed',
        errors: @user.errors.full_messages
      }, status: 422
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: {
        message: 'User Updated Successfully',
        id: @user.id,
        name: @user.name,
        username: @user.username,
        email: @user.email,
        bio: @user.bio
      }, status: 200
    else
      render json: {
        message: 'Validation Failed',
        errors: @user.errors.full_messages
      }, status: 422
    end
  end

  private
    
    def user_params
      {
        device_token: params[:device_token],
        id: params[:id],
        name: params[:name],
        username: params[:username],
        email: params[:email],
        bio: params[:bio], 
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      }
    end
    
    

end
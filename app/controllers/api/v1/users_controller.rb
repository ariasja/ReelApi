class Api::V1::UsersController < ApiController
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render
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
      name: params[:name],
      email: params[:email],
      bio: params[:bio]
    }
  end

end
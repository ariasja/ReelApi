class Api::V1::UsersController < ApiController
  
  def show
    @user = User.find(params[:id])
  end
end
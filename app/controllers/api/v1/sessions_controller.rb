class Api::V1::SessionsController < ApiController

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in(user)
      render json:{ 
        message: 'Session Creation Success',
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        bio: user.bio
      }, status: 200
    else
      render json: {
        message: 'Session Creation Failed',
        errors: 'Invalid email/password combo'
      }, status: 422
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user
      sign_out
      render json: {
        message: 'Session Destroyed'
      }, status: 200
    else
      render json: {
        message: 'Session Not Destroyed'
      }, status: 422
    end
  end

  private
    def sign_in(user)
      remember_token = User.new_remember_token
      cookies.permanent[:remember_token] = remember_token
      user.update_attribute(:remember_token, User.digest(remember_token))
      self.current_user = user
    end

    def sign_out
      current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
      cookies.delete(:remember_token)
      self.current_user = nil
    end

    def signed_in?
      !current_user.nil?
    end

    def current_user=(user)
      @current_user = user
    end

    def current_user
      remember_token = User.digest(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: remember_token)
    end

end

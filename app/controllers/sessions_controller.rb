class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    user = User.find_or_create_from_auth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "successfully logged out"
    redirect_to root_path
  end
end

class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    google_auth = request.env["omniauth.auth"]

    if google_auth.info.email.present?
      user = User.find_and_update_from_auth(google_auth)

      if user
        session[:user_id] = user.id
      else
        flash[:danger] = t('session.error')
      end
    end

    redirect_to root_path
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, flash: { success: t('session.logout') }
  end
end

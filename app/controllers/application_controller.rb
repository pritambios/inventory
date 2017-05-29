class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :authenticate_user
  layout :choose_layout

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    redirect_to root_path unless current_user
  end

  def find_user_or_employee(google_auth)
    User.find_by(email: google_auth.info.email) || Employee.find_by(email: google_auth.info.email)
  end

  protected

  def choose_layout
    return false if request.xhr?
    return params[:layout] if params[:layout].present?
  end
end

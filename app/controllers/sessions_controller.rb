class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    google_auth = request.env["omniauth.auth"]

    if google_auth.info.email.present?
      user_or_employee = find_user_or_employee(google_auth)

      if user_or_employee.try(:update_from_auth, google_auth)
        session[user_or_employee.class.name.downcase.concat("_id").to_sym] = user_or_employee.id
      else
        flash[:danger] = t('session.error')
      end
    end

    if user_or_employee.class.name == "Employee"
      redirect_to employee_issues_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path, flash: { success: t('session.logout') }
  end
end

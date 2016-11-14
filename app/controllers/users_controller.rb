class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, flash: { success: "User is added" }
    else
      redirect_to users_path, flash: { danger: "Sorry!!..Invalid email" }
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to users_path, flash: { success: "User deleted successfully" }
    else
      redirect_to users_path, flash: { danger: "Sorry!!.. Not able to delete this user" }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end

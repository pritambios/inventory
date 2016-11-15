class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :update, :destroy]

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
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to users_path, flash: { success: "User email updated" }
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, flash: { success: "User deleted successfully" }
    else
      redirect_to users_path, flash: { danger: "Sorry!!.. Not able to delete this user" }
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end
end

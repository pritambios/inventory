class UsersController < ApplicationController
  before_action :user, only: [:edit, :update, :destroy]

  def index
    @users = User.order_by_name.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if request.xhr?
      @user.save
    elsif @user.save
      redirect_to :back, flash: { success: t('create') }
    else
      render 'new'
    end
  end

  def update
    if request.xhr?
      @user.update(user_params)
    elsif @user.update(user_params)
      redirect_to :back, flash: { success: t('update') }
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, flash: { success: t('destroy.success') }
    else
      redirect_to users_path, flash: { danger: t('destroy.error') }
    end
  end

  def add_item
    if (item = Item.find_by(id: params[:item]))
      item.update(user_id: @user.id)
    end

    redirect_to user_path
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end
end

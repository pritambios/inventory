class CategoriesController < ApplicationController
  before_action :category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.active.order_by_name.includes(:items).paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if request.xhr?
      @category.save
      flash[:success] = t('create')
    elsif @category.save
      redirect_to :back, flash: { success: t('create') }
    else
      render 'new'
    end
  end

  def edit
    redirect_to categories_path, flash: { error: t('.error') } if @category.items.present?
  end

  def update
    if request.xhr?
      @category.update(category_params)
    elsif @category.update(category_params)
      redirect_to :back, flash: { success: t('update') }
    else
      render 'edit'
    end
  end

  def show
    @category_items = @category.items.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    if @category.items.empty?
      @category.update(deleted_at: Time.zone.now)
      redirect_to categories_path, flash: { success: t('.success') }
    else
      redirect_to categories_path, flash: { error: t('.success') }
    end
  end

  private

  def category
    @category ||= Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

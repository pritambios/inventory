class CategoriesController < ApplicationController
  before_action :get_category, only: [:edit, :update, :destroy]

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
    else
      if @category.save
        redirect_to :back, flash: { success: t('create') }
      else
        render 'new'
      end
    end
  end

  def edit
    redirect_to categories_path, flash: { error: t('.error') } if @category.items.present?
  end

  def update
    if request.xhr?
      @category.update_attributes(category_params)
    else
      if @category.update_attributes(category_params)
        redirect_to :back, flash: { success: t('update') }
      else
        render 'edit'
      end
    end
  end

  def show
    @category_items = @category.items.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    if @category.items.empty?
      @category.update_attributes(deleted_at: Time.now)
      redirect_to categories_path, flash: { success: t('.success') }
    else
      redirect_to categories_path, flash: { error: t('.success') }
    end
  end

  private

  def get_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

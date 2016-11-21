class CategoriesController < ApplicationController
  before_action :get_category, only: [:edit, :update, :show, :destroy]

  def index
    @categories = Category.paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_back(fallback_location: root_path, flash: { success: "Category with #{@category.name} is Created Successfully!" })
    else
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_back(fallback_location: root_path, flash: { success: "Category details successfully updated" })
    else
      render 'edit'
    end
  end

  def show
    @category_items = @category.items.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    flash[:danger] = "#{@category.name} and their items have been removed."
    @category.destroy
    redirect_to categories_path
  end

  private

  def get_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

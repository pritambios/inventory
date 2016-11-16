class BrandsController < ApplicationController
  before_action :get_brand, only: [:edit, :update, :show, :destroy]

  def index
    @brands = Brand.paginate(page: params[:page])
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to :back, flash: { success: "Brand with #{@brand.name} is Created Successfully!" }
    else
      render 'new'
    end
  end

  def update
    if @brand.update(brand_params)
      redirect_to :back, flash: { success: "Brand details successfully updated" }
    else
      render 'edit'
    end
  end

  def show
    @brand_items = @brand.items.paginate(page: params[:page])
  end

  def destroy
    flash[:danger] = "#{@brand.name} and their articles have been removed."
    @brand.destroy
    redirect_to brands_path
  end

  private

  def get_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name)
  end
end

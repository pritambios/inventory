class BrandsController < ApplicationController
  before_action :get_brand, only: [:edit, :update]

  def index
    @brands = Brand.order_by_name.paginate(page: params[:page])
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if request.xhr?
      @brand.save
    else
      if @brand.save
        redirect_back(fallback_location: root_path, flash: { success: t('create') })
      else
        render 'new'
      end
    end
  end

  def update
    if request.xhr?
      @brand.update_attributes(brand_params)
    else
      if @brand.update_attributes(brand_params)
        redirect_back(fallback_location: root_path, flash: { success: t('update') })
      else
        render 'edit'
      end
    end
  end

  def show
    @brand_items = @brand.items.paginate(page: params[:page])
  end

  private

  def get_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name)
  end
end

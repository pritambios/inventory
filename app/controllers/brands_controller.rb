class BrandsController < ApplicationController
  before_action :get_brand, only: [:edit, :update, :destroy]

  def index
    @brands = Brand.active.order_by_name.includes(:items).paginate(page: params[:page])
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if request.xhr?
      @brand.save
      flash[:success] = t('create')
    else
      if @brand.save
        redirect_to :back, flash: { success: t('create') }
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
        redirect_to :back, flash: { success: t('update') }
      else
        render 'edit'
      end
    end
  end

  def show
    @brand_items = @brand.items.paginate(page: params[:page])
  end

  def edit
    redirect_to brands_path, flash: { error: t('.error') } if @brand.items.present?
  end

  def destroy
    if @brand.items.empty?
      @brand.update_attributes(deleted_at: Time.now)
      redirect_to brands_path, flash: { success: t('.success') }
    else
      redirect_to brands_path, flash: { error: t('.error') }
    end
  end

  private

  def get_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name)
  end
end

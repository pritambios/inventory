class BrandsController < ApplicationController
  before_action :brand, only: [:edit, :update, :destroy]

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
    elsif @brand.save
      redirect_back(fallback_location: root_path, flash: { success: t('create') })
    else
      render 'new'
    end
  end

  def update
    if request.xhr?
      @brand.update(brand_params)
    elsif @brand.update(brand_params)
      redirect_back(fallback_location: root_path, flash: { success: t('update') })
    else
      render 'edit'
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
      @brand.update(deleted_at: Time.zone.now)
      redirect_to brands_path, flash: { success: t('.success') }
    else
      redirect_to brands_path, flash: { error: t('.error') }
    end
  end

  private

  def brand
    @brand ||= Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name)
  end
end

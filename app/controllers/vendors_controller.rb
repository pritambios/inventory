class VendorsController < ApplicationController
  before_action :get_vendor, only: [:edit, :update, :show]

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)

    if request.xhr?
      @vendor.save
    else
      if @vendor.save
        redirect_to :back, flash: { success: t('create') }
      else
        render 'new'
      end
    end
  end

  def update
    if request.xhr?
      @vendor.update_attributes(vendor_params)
    else
      if @vendor.update_attributes(vendor_params)
        redirect_to :back, flash: { success: t('update') }
      else
        render 'edit'
      end
    end
  end

  def index
    @vendors = Vendor.order_by_name.paginate(page: params[:page])
  end

  def show
    @items = @vendor.items.includes(:brand, :category).order_desending.paginate(page: params[:items_page])
  end

  private

  def get_vendor
    @vendor = Vendor.find(params[:id])
  end

  def vendor_params
    params.require(:vendor).permit(:name, :email, :mobile, :address, :city, :state)
  end
end

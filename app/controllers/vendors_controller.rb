class VendorsController < ApplicationController
  before_action :get_vendor, only: [:edit, :update, :show]

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      redirect_to :back, flash: { success: "Vendor with #{@vendor.name} successfully created!" }
    else
      render 'new'
    end
  end

  def update
    if @vendor.update_attributes(vendor_params)
      redirect_to :back, flash: { success: "Vendor details successfully updated!" }
    else
      render 'edit'
    end
  end

  def index
    @vendors = Vendor.paginate(page: params[:page])
  end

  def show
    @items = @vendor.items.order_desending.paginate(page: params[:items_page])
  end

  private

  def get_vendor
    @vendor = Vendor.find(params[:id])
  end

  def vendor_params
    params.require(:vendor).permit(:name, :email, :mobile, :address, :city, :state)
  end
end

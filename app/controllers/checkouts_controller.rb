class CheckoutsController < ApplicationController
  before_action :get_checkout, only: [:edit, :update, :show, :checkin]

  def new
    @checkout = Checkout.new
  end

  def create
    @checkout = Checkout.new(checkout_params)

    if @checkout.save
      redirect_back(fallback_location: root_path, flash: { success: "Checkout with #{@checkout.item.serial_number} is recorded Successfully!" })
    else
      render 'new'
    end
  end

  def update
    if @checkout.update_attributes(checkout_params)
      redirect_back(fallback_location: root_path, flash: { success: "Checkout details successfully updated" })
    else
      render 'edit'
    end
  end

  def index
    if params[:item_id].nil?
      @checkouts = Checkout.order_desending.includes(:employee, item: [:brand, :category]).paginate(page: params[:page])
    else
      @checkouts = Item.find(params[:item_id]).checkouts.order_desending.includes(:employee, item: [:brand, :category]).paginate(page: params[:page])
    end
  end

  def checkin
    @checkout.update_attribute(:check_in , Time.now)
    redirect_to checkouts_path
  end

  private

  def get_checkout
    @checkout = Checkout.find(params[:id])
  end

  def checkout_params
    params.require(:checkout).permit(:employee_id, :item_id, :checkout, :check_in, :reason)
  end
end

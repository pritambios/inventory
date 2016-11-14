class CheckoutsController < ApplicationController
  before_action :get_checkout, only: [:edit, :update, :show, :checkin]

  def new
    @checkout = Checkout.new
  end

  def create
    @checkout = Checkout.new(checkout_params)

    if @checkout.save
      flash[:success] = "#{@checkout.item.serial_number} is recorded Successfully!"
      redirect_to checkouts_path
    else
      render 'new'
    end
  end

  def update
    if @checkout.update_attributes(checkout_params)
      flash[:success] = "Checkout Details Updated"
      redirect_to checkouts_path
    else
      render 'edit'
    end
  end

  def index
    @checkouts = Checkout.order_desending.paginate(page: params[:page])
  end

  def checkin
    @checkout.update_attribute(:checking_in , Time.now)
    redirect_to checkouts_path
  end

  private

  def get_checkout
    @checkout = Checkout.find(params[:id])
  end

  def checkout_params
    params.require(:checkout).permit(:employee_id, :item_id, :checking_out, :reason)
  end
end

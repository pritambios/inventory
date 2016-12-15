class CheckoutsController < ApplicationController
  before_action :get_checkout, only: [:edit, :update, :show, :checkin]

  def new
    @checkout = Checkout.new
  end

  def create
    @checkout = Checkout.new(checkout_params)

    if request.xhr?
      @checkout.save
    else
      if @checkout.save
        redirect_to :back, flash: { success: t('create') }
      else
        render 'new'
      end
    end
  end

  def update
    if request.xhr?
      @checkout.update_attributes(checkout_params)
    else
      if @checkout.update_attributes(checkout_params)
        redirect_to :back, flash: { success: t('update') }
      else
        render 'edit'
      end
    end
  end

  def index
    @checkouts = Checkout.includes(item: [:brand, :category]).paginate(page: params[:page]).order_desending
    @checkouts = @checkouts.where(item_id: params[:item_id]) if params[:item_id].present?
    @checkouts = @checkouts.paginate(page: params[:page])
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

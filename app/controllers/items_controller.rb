class ItemsController < ApplicationController
  before_action :get_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.paginate(page: params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item), flash: { success: "Item with #{@item.model_number} is Created Successfully!" }
    else
      render 'new'
    end
  end

  def update
    if @item.update_attributes(item_params)
      redirect_to item_path(@item), flash: { success: "Item details successfully updated" }
    else
      render 'edit'
    end
  end

  def show
    @item_histories = @item.item_histories.order_desending.paginate(page: params[:item_histories_page])
    @checkouts = @item.checkouts.order_desending.paginate(page: params[:checkouts_page])
  end

  def destroy
    if @item.destroy
      redirect_to items_path, flash: { success: "Item was successfully deleted" }
    else
      redirect_to items_path, flash: { danger: "Sorry!!, not able to delete this item" }
    end
  end

  private

  def get_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:model_number, :category_id, :brand_id, :serial_number, :purchase_on, :purchase_from, :purchase_note, :working, :system_id, :employee_id, :warranty_expires_on)
  end
end

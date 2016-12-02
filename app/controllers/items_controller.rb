class ItemsController < ApplicationController
  before_action :get_item, only: [:show, :edit, :update, :destroy, :allocate, :reallocate]

  def index
    @items = Item.includes(:brand, :category, :checkouts)

    if params[:discarded] == "true"
      @items = @items.discarded
    else
      @items = @items.active
    end

    @items = @items.paginate(page: params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_back(fallback_location: root_path, flash: { success: "Item with #{@item.model_number} is Created Successfully!" })
    else
      render 'new'
    end
  end

  def update
    if @item.update_attributes(item_params)
      redirect_back(fallback_location: root_path, flash: { success: "Item details successfully updated" })
    else
      render 'edit'
    end
  end

  def show
    @item_histories = @item.item_histories.order_desending.includes(:system).paginate(page: params[:item_histories_page])
    @checkouts      = @item.checkouts.order_desending.paginate(page: params[:checkouts_page])
    @issues         = @item.issues.includes(:system).order_desending.paginate(page: params[:issues_page])
  end

  def reallocate
    @item.update_attribute(reallocate_employee_params)
    redirect_back(fallback_location: root_path, flash: { success: "Item is successfully reallocated" })
  end

  def destroy
    @item.update_attributes(working: false, discarded_at: Time.now)
    redirect_to items_path, flash: { success: "Item is successfully removed from the list" }
  end

  private

  def get_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:model_number, :category_id, :brand_id, :serial_number, :purchase_on, :vendor_id, :working, :system_id, :employee_id, :warranty_expires_on)
  end

  def reallocate_employee_params
    params.require(:item).permit(:employee_id)
  end
end

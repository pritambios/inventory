class ItemsController < ApplicationController
  before_action :get_item, only: [:show, :edit, :update, :destroy, :discard, :allocate, :reallocate]

  def index
    @items = Item.includes(:brand, :category, :issues, :checkouts)
    @items = @items.not_erased.active
    @items = @items.paginate(page: params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if request.xhr?
      @item.save
    else
      if @item.save
        redirect_to :back, flash: { success: t('create') }
      else
        render 'new'
      end
    end
  end

  def update
    if request.xhr?
      @item.update_attributes(item_params)
    else
      if @item.update_attributes(item_params)
        redirect_to :back, flash: { success: t('update') }
      else
        render 'edit'
      end
    end
  end

  def show
    @item_histories = @item.item_histories.order_desending.includes(:system).paginate(page: params[:item_histories_page])
    @checkouts      = @item.checkouts.order_desending.paginate(page: params[:checkouts_page])
    @issues         = @item.issues.includes(:system).order_desending.paginate(page: params[:issues_page])
  end

  def reallocate
    @item.reallocate(reallocate_employee_params["employee_id"])
    redirect_to :back, flash: { success: t('reallocate') }
  end

  def destroy
    @item.update_attributes(working: false, deleted_at: Time.now)
    redirect_to items_path, flash: { success: t('destroy.success') }
  end

  def discard
    @item.update_attributes(working: false, discarded_at: Time.now)
    redirect_to items_path, flash: { success: t('discard') }
  end

  private

  def get_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:model_number, :category_id, :brand_id, :serial_number, :purchase_on, :vendor_id, :working, :system_id, :employee_id, :warranty_expires_on, documents_attributes: [:title, :attachment])
  end

  def reallocate_employee_params
    params.require(:item).permit(:employee_id)
  end
end

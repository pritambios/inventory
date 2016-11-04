class ItemsController < ApplicationController
  before_action :get_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.paginate(page: params[:page], per_page: 10)
    @users = User.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:success] = "Item with #{@item.model_number} is Created Successfully!"
      redirect_to item_path(@item)
    else
      render 'new'
    end
  end

  def update
    if @item.update_attributes(item_params)
      flash[:success] = "Item Details Successfully Updated"
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def show
    @item_histories = @item.item_histories.order_desending.paginate(page: params[:item_histories_page])
    @checkouts = @item.checkouts.order_desending.paginate(page: params[:checkouts_page])
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def history
    @item = Item.find(params[:format])
    @histories = @item.allocation_histories.paginate(page: params[:page], per_page: 10).order("updated_at DESC")
  end

  def reallocate
    @item = Item.find(params[:id])

    if @item.update(reallocate_user_params)
      @allocation = @item.save_allocation_history(@item.user)
      flash[:success] = "item is successfully reallocated"
      redirect_to history_path(@item)
    end
  end

  def deallocate
    @item = Item.find(params[:format])
    @last_allocation = @item.allocation_histories.allotement.first

    if @last_allocation
      @item.user_id = current_user.id
      @item.save
      @allocation = @item.save_deallocation_history(@last_allocation.user)
      flash[:success] = "Item was successfully deallocated, Now it is reallocated to Admin"
      redirect_to history_path(@item)
    end
  end

  private

  def get_item
    @item = Item.find(params[:id])
  end

  def reallocate_user_params
    params.require(:item).permit(:user_id)
  end

  def item_params
    params.require(:item).permit(:model_number, :category_id, :brand_id, :serial_number, :purchase_on, :purchase_from, :purchase_note, :working, :system_id, :employee_id, :warranty_expires_on)
  end

  def require_same_user
    return if current_user == @item.user || current_user.admin?

    flash[:danger] = 'You can only edit or delete your own articles.'
    redirect_to articles_path
  end
end

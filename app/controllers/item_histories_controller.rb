class ItemHistoriesController < ApplicationController
  def index
    @item_history = ItemHistory.find(params[:id])
    @item_histories = ItemHistory.paginate(page: params[:page])
  end
end

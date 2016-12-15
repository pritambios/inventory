class ResolutionsController < ApplicationController
  before_action :get_resolution, only: [:edit, :update]

  def index
    @resolutions = Resolution.order_by_name.paginate(page: params[:page])
  end

  def new
    @resolution = Resolution.new
  end

  def create
    @resolution = Resolution.new(resolution_params)

    if request.xhr?
      @resolution.save
    else
      if @resolution.save
        redirect_to :back, flash: { success: t('create') }
      else
        render 'new'
      end
    end
  end

  def update
    if request.xhr?
      @resolution.update_attributes(resolution_params)
    else
      if @resolution.update_attributes(resolution_params)
        redirect_to :back, flash: { success: t('update') }
      else
        render 'edit'
      end
    end
  end

  private

  def get_resolution
    @resolution = Resolution.find(params[:id])
  end

  def resolution_params
    params.require(:resolution).permit(:name)
  end
end

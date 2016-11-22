class ResolutionsController < ApplicationController
  before_action :get_resolution, only: [:edit, :update]

  def index
    @resolutions = Resolution.paginate(page: params[:page])
  end

  def new
    @resolution = Resolution.new
  end

  def create
    @resolution = Resolution.new(resolution_params)

    if @resolution.save
      redirect_back(fallback_location: root_path, flash: { success: "Resolution is added" })
    else
      render 'new'
    end
  end

  def update
    if @resolution.update_attributes(resolution_params)
      redirect_back(fallback_location: root_path, flash: { success: "Resolution updated" })
    else
      render 'edit'
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
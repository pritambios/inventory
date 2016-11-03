class SystemsController < ApplicationController
  before_action :get_system, only: [:edit, :update, :show, :destroy]

  def index
    @systems = System.paginate(page: params[:page])
  end

  def new
    @system = System.new
  end

  def create
    @system = System.new(system_params)

    if @system.save
      flash[:success] = "System was successfully created"
      redirect_to system_path(@system)
    else
      render 'new'
    end
  end

  def show
    @system_histories = @system.system_histories.order_desending.paginate(page: params[:page])
  end

  def update
    if @system.update_attributes(system_params)
      flash[:success] = "System Details Updated"
      redirect_to system_path(@system)
    else
      render 'edit'
    end
  end

  def destroy
    if @system.destroy
      flash[:success] = "System Details Deleted"
      redirect_to systems_path
    else
      flash[:danger] = "Unable To delete the details"
      redirect_to systems_path
    end
  end

  private

  def get_system
    @system = System.find(params[:id])
  end

  def system_params
    params.require(:system).permit(:employee_id, :assembled_on, :discarded_at, :working, :note)
  end
end

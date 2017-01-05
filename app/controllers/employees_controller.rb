class EmployeesController < ApplicationController
  before_action :get_employee, only: [:edit, :update, :show, :destroy]

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    if request.xhr?
      @employee.save
    else
      if @employee.save
        redirect_to :back, flash: { success: t('create') }
      else
        render 'new'
      end
    end
  end

  def update
    if request.xhr?
      @employee.update_attributes(employee_params)
    else
      if @employee.update_attributes(employee_params)
        redirect_to :back, flash: { success: t('update') }
      else
        render 'edit'
      end
    end
  end

  def index
    @employees = Employee.order_by_name.paginate(page: params[:page])
  end

  def show
    @items = @employee.items.includes(:brand, :category).order_desending.paginate(page: params[:items_page])
    @systems = @employee.systems.includes(items: [:brand, :category]).order_desending.paginate(page: params[:systems_page])
  end

  def destroy
    @employee.update_attributes(active: false)

    if @employee.destroy
      redirect_to employees_path, flash: { success: t('destroy.success') }
    end
  end

  private

  def get_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :active)
  end
end

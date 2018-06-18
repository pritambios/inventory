class EmployeesController < ApplicationController
  before_action :employee, only: [:edit, :update, :show, :destroy, :allocate_item, :add_item]

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    if request.xhr?
      @employee.save
    elsif @employee.save
      redirect_to :back, flash: { success: t('create') }
    else
      render 'new'
    end
  end

  def update
    if request.xhr?
      @employee.update(employee_params)
    elsif @employee.update(employee_params)
      redirect_to :back, flash: { success: t('update') }
    else
      render 'edit'
    end
  end

  def index
    @employees = Employee.order_by_name.paginate(page: params[:page])
    @employees = @employees.filter_by_status(params[:status]) if params[:status].present?
  end

  def show
    @items = @employee.items.includes(:brand, :category).order_descending.paginate(page: params[:items_page])
  end

  def add_item
    if (item = Item.find_by(id: params[:item]))
      item.update(employee_id: @employee.id)
    end

    redirect_to employee_path
  end

  def fetch
    FetchExternalEmployee.add_employees
    redirect_to employees_path
  end

  private

  def employee
    @employee ||= Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :active, :id)
  end
end

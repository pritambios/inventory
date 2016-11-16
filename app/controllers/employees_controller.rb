class EmployeesController < ApplicationController
  before_action :get_employee, only: [:edit, :update, :show, :destroy]

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to :back, flash: { success: "Employee with #{@employee.name} is Created Successfully!" }
    else
      render 'new'
    end
  end

  def update
    if @employee.update_attributes(employee_params)
      redirect_to :back, flash: { success: "Employee Details successfully updated!" }
    else
      render 'edit'
    end
  end

  def index
    @employees = Employee.paginate(page: params[:page])
  end

  def show
    @items = @employee.items.includes(:brand, :category).order_desending.paginate(page: params[:items_page])
    @systems = @employee.systems.includes(items: [:brand, :category]).order_desending.paginate(page: params[:systems_page])
  end

  def destroy
    if @employee.destroy
      flash[:success] = "Employee Details Deleted"
      redirect_to employees_path
    else
      flash[:danger] = "Unable To delete the details"
      redirect_to employees_path
    end
  end

  private

  def get_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :mobile, :designation, :active)
  end
end

class EmployeesController < ApplicationController
  before_action :get_employee, only: [:show]

  def index
    @employees = Employee.particular_company.all
  end

  def show
    @items = @employee.items.includes(:brand, :category).order_desending.paginate(page: params[:items_page])
    @systems = @employee.systems.includes(items: [:brand, :category]).order_desending.paginate(page: params[:systems_page])
  end

  private

  def get_employee
    @employee = Employee.find(params[:id], { company_id: '1'})
  end
end

class EmployeesController < ApplicationController

  def index
    @employees = Employee.company_employees
  end

  def show
    @employee = Employee.find(params[:id], { company_id: Rails.application.config.company_id })
    @items = @employee.items.includes(:brand, :category).order_desending.paginate(page: params[:items_page])
    @systems = @employee.systems.includes(items: [:brand, :category]).order_desending.paginate(page: params[:systems_page])
  end
end

class FetchExternalEmployees < ActiveRecord::Migration
  def up
    FetchExternalEmployee.add_employees.each do |emp|
      if employee = Employee.find_by(external_id: emp.id)
        Item.where(employee_id: emp.id).update_all(employee_id: employee.id)
        System.where(employee_id: emp.id).update_all(employee_id: employee.id)
        Checkout.where(employee_id: emp.id).update_all(employee_id: employee.id)
        ItemHistory.where(employee_id: emp.id).update_all(employee_id: employee.id)
        SystemHistory.where(employee_id: emp.id).update_all(employee_id: employee.id)
      end
    end
  end

  def down
  end
end

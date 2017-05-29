class FetchExternalEmployee
  def self.add_employees
    ExternalEmployee.company_employees.each do |emp|
      employee = Employee.find_or_create_by(email: emp.email, external_id: emp.id)
      employee.name = emp.name
      employee.save
    end
  end
end

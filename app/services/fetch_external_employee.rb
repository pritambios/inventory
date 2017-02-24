class FetchExternalEmployee
  def self.add_employees
    ExternalEmployee.company_employees.each do |emp|
      employee = Employee.find_or_create_by(name: emp.name, external_id: emp.id)
      employee.email = emp.email
      employee.save
    end
  end
end

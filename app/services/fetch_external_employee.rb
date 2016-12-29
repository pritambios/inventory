class FetchExternalEmployee
  def self.add_employees
    ExternalEmployee.company_employees.each do |employee|
      Employee.create_with(external_id: employee.id).find_or_create_by(name: employee.name, external_id: employee.id)
    end
  end
end

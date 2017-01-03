class FetchExternalEmployee
  def self.add_employees
    ExternalEmployee.company_employees.each do |emp|
      Employee.find_or_create_by(name: emp.name, external_id: emp.id)
    end
  end
end

task fetch_external_employee: :environment do
  FetchExternalEmployee.add_employees
end

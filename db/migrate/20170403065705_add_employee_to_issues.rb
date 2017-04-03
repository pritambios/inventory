class AddEmployeeToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :employee_id, :integer
  end
end

class RemoveEmployeeTableAndConstrain < ActiveRecord::Migration[5.0]
  def up
    remove_column :items, :employee_id
    remove_column :systems, :employee_id
    remove_column :checkouts, :employee_id
    remove_column :item_histories, :employee_id
    remove_column :system_histories, :employee_id
    drop_table :employees
    add_column :items, :employee_id, :integer
    add_column :systems, :employee_id, :integer
    add_column :checkouts, :employee_id, :integer
    add_column :item_histories, :employee_id, :integer
    add_column :system_histories, :employee_id, :integer
  end
end

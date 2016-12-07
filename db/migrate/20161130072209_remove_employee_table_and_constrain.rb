class RemoveEmployeeTableAndConstrain < ActiveRecord::Migration[5.0]
  def up
    remove_foreign_key :items, :employees
    remove_reference :items, :employee, index: true
    remove_foreign_key :systems, :employees
    remove_reference :systems, :employee, index: true
    remove_foreign_key :checkouts, :employees
    remove_reference :checkouts, :employee, index: true
    remove_foreign_key :item_histories, :employees
    remove_reference :item_histories, :employee, index: true
    remove_foreign_key :system_histories, :employees
    remove_reference :system_histories, :employee, index: true
    drop_table :employees
    add_column :items, :employee_id, :integer
    add_column :systems, :employee_id, :integer
    add_column :checkouts, :employee_id, :integer
    add_column :item_histories, :employee_id, :integer
    add_column :system_histories, :employee_id, :integer
  end
end

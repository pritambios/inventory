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

  def down
    create_table :employees do |t|
      t.string :name
      t.string :email, null: false
      t.string :mobile
      t.string :designation, null: false
      t.boolean :active, default: true
      t.timestamps
    end
    remove_column :items, :employee_id
    remove_column :systems, :employee_id
    remove_column :checkouts, :employee_id
    remove_column :item_histories, :employee_id
    remove_column :system_histories, :employee_id
    add_reference :items, :employee, foreign_key: true, index: true
    add_reference :systems, :employee, foreign_key: true, index: true
    add_reference :checkouts, :employee, foreign_key: true, index: true
    add_reference :item_histories, :employee, foreign_key: true, index: true
    add_reference :system_histories, :employee, foreign_key: true, index: true
  end
end

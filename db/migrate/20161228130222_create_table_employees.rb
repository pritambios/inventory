class CreateTableEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :email
      t.boolean :active, default: true
      t.integer :external_id

      t.timestamps
    end

    # remove_column :items, :employee_id, :integer
    # remove_column :item_histories, :employee_id, :integer
    # remove_column :systems, :employee_id, :integer
    # remove_column :system_histories, :employee_id, :integer
    # remove_column :checkouts, :employee_id, :integer
    # add_reference :items, :employee, index: true, foreign_key: true
    # add_reference :item_histories, :employee, index: true, foreign_key: true
    # add_reference :systems, :employee, index: true, foreign_key: true
    # add_reference :system_histories, :employee, index: true, foreign_key: true
    # add_reference :checkouts, :employee, index: true, foreign_key: true
  end
end

class CreateSystemHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :system_histories do |t|
      t.belongs_to :system, null: false
      t.belongs_to :employee
      t.boolean :status, null: false
      t.text :note
      t.timestamps
    end
    add_foreign_key :system_histories, :systems
    add_foreign_key :system_histories, :employees
  end
end

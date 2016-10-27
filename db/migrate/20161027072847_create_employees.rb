class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email, null: false
      t.string :mobile
      t.string :designation, null: false
      t.boolean :active, default: true
      t.timestamps
    end
  end
end

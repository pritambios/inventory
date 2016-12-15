class CreateEmployees < ActiveRecord::Migration
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

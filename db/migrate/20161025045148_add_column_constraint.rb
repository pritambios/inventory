class AddColumnConstraint < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :name, :text, null: false, limit: 50
    change_column :items, :description, :text, null: false, limit: 1000
    change_column :items, :model_number, :text, null: false, limit: 25
    change_column :items, :quantity, :integer, null: false
    change_column :items, :unit_price, :decimal, null: false
    change_column :items, :total_value, :decimal, null: false
    add_foreign_key :items, :users
  end
end

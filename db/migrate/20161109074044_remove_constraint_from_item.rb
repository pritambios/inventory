class RemoveConstraintFromItem < ActiveRecord::Migration[5.0]
  def up
    change_column :items, :model_number, :string, null: true
    change_column :items, :purchase_from, :string, null: true
    change_column :items, :brand_id, :integer, null: true
  end

  def down
    change_column :items, :model_number, :string, null: false
    change_column :items, :purchase_from, :string, null: false
    change_column :items, :brand_id, :integer, null: false
  end
end

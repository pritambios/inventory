class ItemPurchaseOnNotMandatory < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :purchase_on, :date, null: true
  end
end

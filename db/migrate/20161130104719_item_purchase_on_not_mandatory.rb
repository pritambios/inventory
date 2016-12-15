class ItemPurchaseOnNotMandatory < ActiveRecord::Migration
  def change
    change_column :items, :purchase_on, :date, null: true
  end
end

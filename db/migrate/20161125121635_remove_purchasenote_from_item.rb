class RemovePurchasenoteFromItem < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :purchase_note
  end
end

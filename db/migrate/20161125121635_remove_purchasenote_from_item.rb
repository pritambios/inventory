class RemovePurchasenoteFromItem < ActiveRecord::Migration
  def change
    remove_column :items, :purchase_note
  end
end

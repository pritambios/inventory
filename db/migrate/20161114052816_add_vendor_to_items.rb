class AddVendorToItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :items, :vendor, foreign_key: true
    remove_column :items, :purchase_from, :string
  end
end

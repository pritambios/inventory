class AddVendorToItems < ActiveRecord::Migration
  def change
    add_reference :items, :vendor, foreign_key: true
    remove_column :items, :purchase_from, :string
  end
end

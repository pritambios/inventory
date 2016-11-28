class VendorAddressMandatroy < ActiveRecord::Migration[5.0]
  def up
    change_column :vendors, :address, :string, null: false
  end

  def down
    change_column :vendors, :address, :string, null: true
  end
end

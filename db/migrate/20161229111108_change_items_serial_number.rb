class ChangeItemsSerialNumber < ActiveRecord::Migration
  def change
    change_column :items, :serial_number, :string, null: true
  end
end

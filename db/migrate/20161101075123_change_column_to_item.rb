class ChangeColumnToItem < ActiveRecord::Migration
  def change
    rename_column :items, :warrenty_expired_on, :warranty_expires_on
  end
end

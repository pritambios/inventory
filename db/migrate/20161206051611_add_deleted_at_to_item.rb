class AddDeletedAtToItem < ActiveRecord::Migration
  def change
    add_column :items, :deleted_at, :date
  end
end

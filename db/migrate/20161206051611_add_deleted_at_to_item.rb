class AddDeletedAtToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :deleted_at, :date
  end
end

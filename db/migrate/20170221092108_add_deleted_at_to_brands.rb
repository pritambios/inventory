class AddDeletedAtToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :deleted_at, :date
  end
end

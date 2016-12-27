class AddDeletedAtToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :deleted_at, :date
  end
end

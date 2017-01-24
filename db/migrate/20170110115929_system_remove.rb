class SystemRemove < ActiveRecord::Migration
  def up
    remove_foreign_key :items, :system
    remove_reference :items, :system, index: true
    remove_foreign_key :item_histories, :system
    remove_reference :item_histories, :system, index: true
    remove_foreign_key :issues, :system
    remove_reference :issues, :system, index: true
    remove_foreign_key :system_histories, :system
    remove_reference :system_histories, :system, index: true
    add_column :items, :parent_id, :integer
    drop_table :systems
    drop_table :system_histories
  end

  def down
    remove_column :items, :parent_id, :integer
  end
end

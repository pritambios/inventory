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
  end
  def down
    add_reference :items,:system, foreign_key: true
    add_reference :item_histories,:system,  foreign_key: true
    add_reference :issues,:system, foreign_key: true
    add_reference :system_histories,:system, foreign_key: true
    remove_column :items, :parent_id, :integer
  end
end

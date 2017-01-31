class AddParentIdToSystemHistories < ActiveRecord::Migration
  def up
    add_column :item_histories, :parent_id, :integer
  end

  def down
    remove_column :item_histories, :parent_id, :integer
  end
end

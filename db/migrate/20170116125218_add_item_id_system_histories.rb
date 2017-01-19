class AddItemIdSystemHistories < ActiveRecord::Migration
  def up
    add_reference :system_histories, :item, foreign_key: true
  end

  def down
    remove_foreign_key :system_histories, :item
    remove_reference :system_histories, :item
  end
end

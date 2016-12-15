class AddSoftDeleteItem < ActiveRecord::Migration
  def change
    add_column :items, :discarded_at, :date
  end
end

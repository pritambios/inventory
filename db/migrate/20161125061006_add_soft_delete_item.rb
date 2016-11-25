class AddSoftDeleteItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :discarded_at, :date
  end
end

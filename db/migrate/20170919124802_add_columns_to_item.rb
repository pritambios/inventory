class AddColumnsToItem < ActiveRecord::Migration
  def change
    add_column :items, :approved_by_id, :integer
    add_foreign_key :items, :users, column: :approved_by_id

    add_column :items, :rejected_by_id, :integer
    add_foreign_key :items, :users, column: :rejected_by_id

    add_column :items, :approved_at, :datetime
    add_column :items, :rejected_at, :datetime
  end
end

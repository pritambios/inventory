class DeleteAllocationHistories < ActiveRecord::Migration[5.0]
  def change
    drop_table :allocation_histories
  end
end

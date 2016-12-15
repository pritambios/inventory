class DeleteAllocationHistories < ActiveRecord::Migration
  def change
    drop_table :allocation_histories
  end
end

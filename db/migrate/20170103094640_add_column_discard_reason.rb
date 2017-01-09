class AddColumnDiscardReason < ActiveRecord::Migration
  def up
    add_column :items, :discard_reason, :string
  end

  def down
    remove_column :items, :discard_reason, :string
  end
end

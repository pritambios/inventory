class RemoveSystemHistory < ActiveRecord::Migration
  def up
    drop_table :system_histories
  end

  def down

    create_table :system_histories do |t|
      t.boolean  "status"
      t.text     "note"
      t.integer  "employee_id"
      t.integer  "item_id"
      t.timestamps
    end
  end
end

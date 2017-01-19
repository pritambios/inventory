class RemoveSystem < ActiveRecord::Migration
  def up
    drop_table :systems
  end

  def down
    create_table :systems do |t|
      t.date  :assembled_on
      t.date  :discarded_at
      t.boolean :working
      t.text  :note
      t.integer :employee_id
      t.timestamps
    end
  end
end

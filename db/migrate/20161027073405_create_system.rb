class CreateSystem < ActiveRecord::Migration[5.0]
  def change
    create_table :systems do |t|
     t.belongs_to :employee
     t.date :assembled_on
     t.date :discarded_at
     t.boolean :working, default: true
     t.text :note
     t.timestamps
    end
  end
end

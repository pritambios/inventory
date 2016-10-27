class CreateSystem < ActiveRecord::Migration[5.0]
  def change
    create_table :systems do |t|
     t.belongs_to :employee, null: false
     t.date :build_on
     t.date :discarted_at
     t.boolean :working, default: true
     t.text :note
     t.timestamps
    end
  end
end

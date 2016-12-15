class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.belongs_to :item, foreign_key: true
      t.belongs_to :system, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.date :closed_at
      t.text :note
      t.timestamps
    end
  end
end

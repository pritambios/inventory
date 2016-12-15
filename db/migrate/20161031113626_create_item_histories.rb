class CreateItemHistories < ActiveRecord::Migration
  def change
    create_table :item_histories do |t|
      t.belongs_to :item, null: false
      t.boolean :status, null: false
      t.belongs_to :employee
      t.belongs_to :system
      t.string :note, limit: 500

      t.timestamps
    end

    add_foreign_key :item_histories, :items
    add_foreign_key :item_histories, :employees
    add_foreign_key :item_histories, :systems
  end
end

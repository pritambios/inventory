class CreateCheckouts < ActiveRecord::Migration[5.0]
  def change
    create_table :checkouts do |t|
      t.belongs_to :employee, foreign_key: true
      t.belongs_to :item, null: false, foreign_key: true
      t.date :checking_out, null: false
      t.date :checking_in
      t.string :reason, null: false

      t.timestamps
    end
  end
end

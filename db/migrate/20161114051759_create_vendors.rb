class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.string :name, null: false
      t.string :email
      t.string :mobile
      t.string :address
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end

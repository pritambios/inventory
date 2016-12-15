class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end

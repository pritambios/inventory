class ChangeItemColumns < ActiveRecord::Migration[5.0]
  def up
    remove_column :items, :name
    remove_column :items, :description
    remove_column :items, :quantity
    remove_column :items, :unit_price
    remove_column :items, :total_value
    remove_column :items, :image_file_name
    remove_column :items, :image_content_type
    remove_column :items, :image_file_size
    remove_column :items, :image_updated_at
    change_column :items, :category_id, :integer, null: false, index: true
    change_column :items, :brand_id, :integer, null: false, index: true
    add_reference :items, :employee, index: true
    add_reference :items, :system, index: true
    add_column :items, :serial_number, :string, null: false, unique: true
    add_column :items, :purchase_on, :date, null: false
    add_column :items, :purchase_from, :string, null: false
    add_column :items, :purchase_note, :text
    add_column :items, :working, :boolean, default: true
    add_column :items, :warrenty_expired_on, :date
  end

  def down
    remove_reference :items, :employee
    remove_reference :items, :system
    remove_column :items, :serial_number
    remove_column :items, :purchase_on
    remove_column :items, :purchase_from
    remove_column :items, :purchase_note
    remove_column :items, :working
    remove_column :items, :warrenty_expired_on
  end
end

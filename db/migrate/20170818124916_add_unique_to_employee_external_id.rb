class AddUniqueToEmployeeExternalId < ActiveRecord::Migration
  def change
    add_index :employees, :external_id, unique: true
  end
end

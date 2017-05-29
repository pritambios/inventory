class UpdateEmployees < ActiveRecord::Migration
  def up
    add_column :employees, :access_token, :string
    add_column :employees, :google_uid, :string
    change_column_null :employees, :email, false
    change_column_null :employees, :name, true
  end

  def down
    change_column_null :employees, :name, false
    change_column_null :employees, :email, true
    remove_column :employees, :google_uid
    remove_column :employees, :access_token
  end
end

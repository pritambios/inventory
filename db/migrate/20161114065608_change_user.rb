class ChangeUser < ActiveRecord::Migration
  def up
    change_column :users, :first_name, :string, null: true
    change_column :users, :access_token, :string, null: true
    change_column :users, :google_uid, :string, null: true
  end

  def down
    change_column :users, :first_name, :string, null: false
    change_column :users, :access_token, :string, null: false
    change_column :users, :google_uid, :string, null: false
  end
end

class ChangeEmailOnUsers < ActiveRecord::Migration
  def up
    change_column_default(:users, :email, nil)
  end

  def down
    change_column_default(:users, :email, "---\n:from: ''\n:to: \n")
  end
end

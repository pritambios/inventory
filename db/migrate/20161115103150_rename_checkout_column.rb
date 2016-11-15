class RenameCheckoutColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :checkouts, :checking_out, :checkout
    rename_column :checkouts, :checking_in, :check_in
  end
end

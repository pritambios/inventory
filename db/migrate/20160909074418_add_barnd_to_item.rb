class AddBarndToItem < ActiveRecord::Migration
  def change
      add_column :items, :brand_id, :integer
  end
end

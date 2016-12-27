class AddNotesToItems < ActiveRecord::Migration
  def change
    add_column :items, :note, :text
  end
end

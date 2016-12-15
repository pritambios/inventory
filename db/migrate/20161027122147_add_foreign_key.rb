class AddForeignKey < ActiveRecord::Migration
  def change
    add_foreign_key :items, :employees
    add_foreign_key :items, :systems
    add_foreign_key :items, :categories
    add_foreign_key :items, :brands
    add_foreign_key :systems, :employees
  end
end

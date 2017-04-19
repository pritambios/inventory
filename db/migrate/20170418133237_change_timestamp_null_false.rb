class ChangeTimestampNullFalse < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.tables.select{|t| t != "schema_migrations"}.each do |table|
      change_column_null table.to_sym, :created_at, false
      change_column_null table.to_sym, :updated_at, false
    end
  end

  def down
    ActiveRecord::Base.connection.tables.select{|t| t != "schema_migrations"}.each do |table|
      change_column_null table.to_sym, :created_at, true
      change_column_null table.to_sym, :updated_at, true
    end
  end
end

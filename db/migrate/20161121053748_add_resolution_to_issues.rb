class AddResolutionToIssues < ActiveRecord::Migration
  def change
    add_reference :issues, :resolution, foreign_key: true
  end
end

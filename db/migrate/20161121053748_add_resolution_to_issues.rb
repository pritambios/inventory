class AddResolutionToIssues < ActiveRecord::Migration[5.0]
  def change
    add_reference :issues, :resolution, foreign_key: true
  end
end

class RemoveNoteFromIssues < ActiveRecord::Migration
  def change
    remove_column :issues, :note, :text
  end
end

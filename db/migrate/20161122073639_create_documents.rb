class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.attachment :attachment
      t.belongs_to :item, foreign_key: true
      t.timestamps
    end
  end
end

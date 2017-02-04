class CreateDocumentTags < ActiveRecord::Migration[5.0]
  def change
    create_table :document_tags do |t|
      t.belongs_to :document, index: true
      t.belongs_to :tag, index: true

      t.timestamps
    end
  end
end

class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.belongs_to :community, index: true
      t.belongs_to :user, index: true

      t.string :name
      t.string :slug
      t.text :description

      t.timestamps
    end

    add_index :documents, [:community_id, :id]
  end
end

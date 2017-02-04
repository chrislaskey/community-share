class CreateDownloads < ActiveRecord::Migration[5.0]
  def change
    create_table :downloads do |t|
      t.belongs_to :community, index: true
      t.belongs_to :document, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end

    add_index :downloads, [:document_id, :user_id]
    add_index :downloads, [:community_id, :id]
    add_index :downloads, [:community_id, :user_id]
  end
end

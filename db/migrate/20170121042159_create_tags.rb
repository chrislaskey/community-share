class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.belongs_to :community, index: true

      t.string :category
      t.string :category_slug
      t.string :name
      t.string :slug

      t.timestamps
    end

    add_index :tags, [:community_id, :id]
    add_index :tags, [:community_id, :slug]
  end
end

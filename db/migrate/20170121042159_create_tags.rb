class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :category
      t.string :category_slug
      t.string :name
      t.string :slug
      t.timestamps
    end
  end
end

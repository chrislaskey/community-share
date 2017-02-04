class CreateCommunities < ActiveRecord::Migration[5.0]
  def change
    create_table :communities do |t|
      t.integer :uid
      t.string :name
      t.string :slug
      t.text :description

      t.timestamps
    end

    add_index :communities, [:uid]
  end
end

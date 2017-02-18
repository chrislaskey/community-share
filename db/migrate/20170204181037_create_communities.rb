class CreateCommunities < ActiveRecord::Migration[5.0]
  def change
    create_table :communities do |t|
      t.integer :uid
      t.string :name
      t.string :slug
      t.text :description
      t.string :subscription_type
      t.datetime :subscription_start
      t.boolean :read_only

      t.timestamps
    end

    add_index :communities, [:uid]
    add_index :communities, [:subscription_type]
  end
end

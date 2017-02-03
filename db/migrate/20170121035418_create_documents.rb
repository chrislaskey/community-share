class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :user_id
      t.timestamps
    end
  end
end

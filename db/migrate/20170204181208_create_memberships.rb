class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.belongs_to :user, index: true
      t.belongs_to :community, index: true
      t.boolean :current
      t.string :role

      t.timestamps
    end

    add_index :memberships, [:community_id, :user_id]
    add_index :memberships, [:current]
  end
end

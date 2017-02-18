class CommunityLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :community_levels do |t|
      t.string :name
      t.string :slug
      t.integer :file_count_limit
      t.integer :file_size_limit, limit: 8
      t.integer :membership_count_limit
    end

    add_index :community_levels, [:slug]
  end
end

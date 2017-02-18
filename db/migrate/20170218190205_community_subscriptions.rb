class CommunitySubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :community_subscriptions do |t|
      t.belongs_to :community, index: true
      t.belongs_to :community_level, index: true
      t.datetime :started_at
      t.datetime :ended_at
      t.timestamps
    end

    add_index :community_subscriptions, [:community_id, :community_level_id], name: "index_subscriptions_by_community_and_level"
    add_index :community_subscriptions, [:started_at]
    add_index :community_subscriptions, [:ended_at]
  end
end

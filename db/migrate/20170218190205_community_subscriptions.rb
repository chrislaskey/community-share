class CommunitySubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :community_subscriptions do |t|
      t.belongs_to :community, index: true
      t.belongs_to :community_level, index: true
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end

    add_index :community_subscriptions, [:community_id, :community_level_id], name: "index_subscriptions_by_community_and_level"
    add_index :community_subscriptions, [:start_at]
    add_index :community_subscriptions, [:end_at]
  end
end

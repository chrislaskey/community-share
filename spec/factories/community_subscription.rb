FactoryGirl.define do

  factory :community_subscription do
    community
    community_level
    started_at { Time.now }
    ended_at nil
    created_at { Time.now }
    updated_at { Time.now }
  end

end

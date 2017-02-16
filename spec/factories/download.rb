FactoryGirl.define do

  factory :download do
    community
    document
    user
    created_at { Time.now }
    updated_at { Time.now }
  end

end

FactoryGirl.define do

  factory :membership do
    community
    user
    role "admin"
    created_at { Time.now }
    updated_at { Time.now }
  end

end

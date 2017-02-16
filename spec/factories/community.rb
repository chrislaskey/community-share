FactoryGirl.define do

  factory :community do
    uid { SecureRandom::uuid }
    name { Faker::Name.name }
    slug { Faker::Internet.slug }
    description { Faker::RickAndMorty.quote }
    subscription_type "premium"
    subscription_start { Time.now }
    created_at { Time.now }
    updated_at { Time.now }
  end

end

FactoryGirl.define do

  factory :community do
    read_only false
    uid { SecureRandom::uuid }
    name { Faker::Name.name }
    slug { Faker::Internet.slug }
    description { Faker::Name.name }
    created_at { Time.now }
    updated_at { Time.now }
  end

end

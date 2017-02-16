FactoryGirl.define do

  factory :tag do
    community
    category { Faker::Name.name }
    category_slug { Faker::Internet.slug }
    name { Faker::Name.name }
    slug { Faker::Internet.slug }
    created_at { Time.now }
    updated_at { Time.now }
  end

end

FactoryGirl.define do

  factory :document do
    community
    user
    name { Faker::Name.name }
    slug { Faker::Internet.slug }
    description { Faker::Name.name }
    file_file_name { Faker::Name.name }
    file_content_type "application/pdf"
    file_file_size { 1024 * 1024 * SecureRandom::rand(1..100) }
    file_updated_at { Time.now }
    created_at { Time.now }
    updated_at { Time.now }
  end

end

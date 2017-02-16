FactoryGirl.define do

  factory :user do
    provider "facebook"
    uid { SecureRandom::uuid }
    remember_created_at { Time.now }
    sign_in_count { SecureRandom::rand(0..100) }
    current_sign_in_at { Time.now }
    last_sign_in_at { Time.now - 1.week }
    current_sign_in_ip { Faker::Internet.ip_v4_address }
    last_sign_in_ip { Faker::Internet.ip_v4_address }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    image { Faker::Internet.domain_name }
    token { SecureRandom::uuid }
    expires_at { Time.now + 3.months }
    created_at { Time.now }
    updated_at { Time.now }
  end

end

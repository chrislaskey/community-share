FactoryGirl.define do

  factory :community_level do
    name { Faker::Name.name }
    slug { Faker::Internet.slug }
    file_count_limit 2
    file_size_limit 2
    membership_count_limit 2
  end

end

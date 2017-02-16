FactoryGirl.define do

  factory :document_tag do
    document
    tag
    created_at { Time.now }
    updated_at { Time.now }
  end

end

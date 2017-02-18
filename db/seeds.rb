# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

communities = [
  { name: "Demo", read_only: true, slug: "demo", subscription_type: "premium" },
  { name: "Test 1", slug: "test-1", subscription_type: "premium" },
  { name: "Test 2", slug: "test-2", subscription_type: "premium" }
]

communities.map do |community|
  Community.find_or_create_by!(community)
end

default = Community.last

tags = [
  { community: default, category: "Education Level", name: "Pre-K" },
  { community: default, category: "Education Level", name: "Grade 1-4" },
  { community: default, category: "Education Level", name: "Grade 4-8" },
  { community: default, category: "Education Level", name: "Grade 8-12" },
  { community: default, category: "Subject", name: "Biology" },
  { community: default, category: "Subject", name: "Ecology" },
  { community: default, category: "Subject", name: "Math" },
  { community: default, category: "Subject", name: "Physics" }
]

tags.map do |tag|
  Tag.find_or_create_by!(tag)
end

(ENV["ADMIN_USER_EMAILS"] || "").split(",").map do |email|
  user = User.find_or_create_by!(
    email: email
  )

  Membership.find_or_create_by!(
    community: default,
    user: user,
    role: Membership::ROLES.first
  )
end

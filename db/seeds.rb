# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tags = [
  { category: "Education Level", name: "Pre-K" },
  { category: "Education Level", name: "Grade 1-4" },
  { category: "Education Level", name: "Grade 4-8" },
  { category: "Education Level", name: "Grade 8-12" },
  { category: "Subject", name: "Biology" },
  { category: "Subject", name: "Ecology" },
  { category: "Subject", name: "Math" },
  { category: "Subject", name: "Physics" }
]

tags.map do |tag|
  Tag.create(tag)
end

users = [
  { name: "Admin", email: ENV["ADMIN_USER_EMAIL"], role: "admin" }
]

users.map do |user|
  User.create(user)
end

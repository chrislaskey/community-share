communities = [
  { name: "Demo", read_only: true, slug: "demo", subscription_type: "premium" }
]

communities.map do |community|
  Community.find_or_create_by!(community)
end

demo = Community.first

tags = [
  { community: demo, category: "Education Level", name: "Pre-K" },
  { community: demo, category: "Education Level", name: "Grade 1-4" },
  { community: demo, category: "Education Level", name: "Grade 4-8" },
  { community: demo, category: "Education Level", name: "Grade 8-12" },
  { community: demo, category: "Subject", name: "Biology" },
  { community: demo, category: "Subject", name: "Ecology" },
  { community: demo, category: "Subject", name: "Math" },
  { community: demo, category: "Subject", name: "Physics" }
]

tags.map do |tag|
  Tag.find_or_create_by!(tag)
end

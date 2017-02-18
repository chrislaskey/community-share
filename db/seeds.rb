levels = [
  {
    name: "Starter",
    slug: "starter",
    membership_count_limit: 5,
    tag_count_limit: 1000,
    file_count_limit: 30,
    file_size_limit: 100 * 1024 * 1024
  },
  {
    name: "Community",
    slug: "standard",
    membership_count_limit: 100,
    tag_count_limit: 1000,
    file_count_limit: 300,
    file_size_limit: 3 * 1024 * 1024 * 1024
  },
  {
    name: "Premium",
    slug: "premium",
    membership_count_limit: 10000,
    tag_count_limit: 1000,
    file_count_limit: 50000,
    file_size_limit: 20 * 1024 * 1024 * 1024
  }
]

levels.map do |level|
  CommunityLevel.find_or_create_by!(level)
end

communities = [
  { name: "Demo", read_only: true, slug: "demo" }
]

communities.map do |community|
  Community.find_or_create_by!(community)
end

demo = Community.find_by(slug: "demo")

subscriptions = [
  { community: demo, community_level: CommunityLevel.find_by(slug: "premium"), started_at: Time.now }
]

subscriptions.map do |subscription|
  CommunitySubscription.find_or_create_by!(subscription)
end

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

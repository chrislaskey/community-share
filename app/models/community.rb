class Community < ApplicationRecord

  has_many :documents
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy
  has_many :community_subscriptions
  has_many :tags

  alias_attribute :subscriptions, :community_subscriptions

  validates :name, presence: true
  validates :slug, uniqueness: true

  scope :demo, -> {
    find_by(slug: "demo")
  }

  after_initialize :set_slug

  def subscription
    subscriptions.detect(&:active)
  end

  def level
    return nil unless subscription
    subscription.level
  end

  def demo?
    slug == "demo"
  end

  def file_count
    documents.length
  end

  def file_size
    documents.map(&:file_file_size).sum
  end

  def tag_count
    tags.length
  end

  def membership_count
    memberships.select(&:active).length
  end

  def over_limit?(key, extra = 0)
    send(key) + extra.to_i >= level.limit(key)
  end

  private

  def set_slug
    self.slug ||= (name || "").parameterize
  end

end

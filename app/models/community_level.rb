class CommunityLevel < ApplicationRecord

  has_many :community_subscriptions
  has_many :communities, through: :community_subscriptions

  alias_attribute :subscriptions, :community_subscriptions

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :file_count_limit, presence: true
  validates :file_size_limit, presence: true
  validates :membership_count_limit, presence: true

  def limit(key)
    limit_key = key.to_s + "_limit"
    send(limit_key)
  end

end

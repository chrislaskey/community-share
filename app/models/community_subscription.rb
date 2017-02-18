class CommunitySubscription < ApplicationRecord

  belongs_to :community
  belongs_to :community_level

  alias_attribute :level, :community_level

  validates :community, presence: true
  validates :community_level, presence: true
  validates :started_at, presence: true

  before_create :close_active_subscription

  def active
    ended_at.blank?
  end

  private

  def close_active_subscription
    return true unless ended_at.blank?

    CommunitySubscription.where(
      community: community,
      ended_at: nil
    ).update_all(ended_at: Time.now)
  end

end

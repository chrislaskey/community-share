class CommunitySubscription < ApplicationRecord

  belongs_to :community
  belongs_to :community_level

  alias_attribute :level, :community_level

  validates :community, presence: true
  validates :level, presence: true
  validates :start_at, presence: true

  before_create :close_active_subscription

  def active
    end_at.blank?
  end

  private

  def close_active_subscription
    return true unless end_at.blank?

    CommunitySubscription.where(
      community: community,
      end_at: nil
    ).update_all(end_at: Time.now)
  end

end

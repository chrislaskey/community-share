class Membership < ApplicationRecord

  ROLES = %w(admin member pending)
  DEFAULT_ROLE = "pending"
  DEFAULT_COMMUNITY_ROLE = "member"

  belongs_to :community
  belongs_to :user

  validates :community, presence: true
  validates :user, presence: true
  validates :role, inclusion: { in: Membership::ROLES }

  after_initialize :set_role

  private

  def set_role
    self.role ||= Membership::ROLES.last
  end

end

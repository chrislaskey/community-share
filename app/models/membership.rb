class Membership < ApplicationRecord

  ROLES = %w(admin member pending)
  DEFAULT_ROLE = "pending"
  DEFAULT_COMMUNITY_ROLE = "member"

  belongs_to :community
  belongs_to :user

  validates :community, presence: true
  validates :user, uniqueness: { scope: :community }
  validates :role, inclusion: { in: Membership::ROLES }

  after_initialize :set_role
  after_initialize :set_user

  private

  def set_role
    self.role ||= Membership::DEFAULT_ROLE
  end

  def set_user
    self.user ||= User.new
  end

end

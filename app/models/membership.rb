class Membership < ApplicationRecord

  ROLES = %w(admin editor contributor member suspended)
  DEFAULT_ROLE = "member"
  ADMIN_ROLE = "admin"
  ADMIN_ROLE_LIMIT = 30

  belongs_to :community
  belongs_to :user

  validates :community, presence: true
  validates :user, uniqueness: { scope: :community }
  validates :role, inclusion: { in: Membership::ROLES }

  after_initialize :set_role
  after_initialize :set_user

  scope :admin_memberships, ->(user) {
    where(user: user, role: Membership::ADMIN_ROLE)
  }

  def active
    role != "suspended"
  end

  def login
    user.memberships.map do |membership|
      membership.update_attributes(current: false)
    end

    update_attributes(current: true)
  end

  private

  def set_role
    self.role ||= Membership::DEFAULT_ROLE
  end

  def set_user
    self.user ||= User.new
  end

end

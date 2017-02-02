class User < ApplicationRecord

  ROLES = %w(admin default pending)

  devise :rememberable, :timeoutable, :trackable, :omniauthable, omniauth_providers: [:facebook]

  validates :role, inclusion: {
    in: User::ROLES
  }

  after_initialize :set_role

  private

  def set_role
    self.role ||= User::ROLES.last
  end

  def timeout_in
    1.days
  end

end

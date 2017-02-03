class User < ApplicationRecord

  include ActionView::Helpers::DateHelper

  ROLES = %w(admin member pending)

  devise :rememberable, :timeoutable, :trackable, :omniauthable, omniauth_providers: [:facebook]

  validates :email, uniqueness: true
  validates :name, presence: true
  validates :role, inclusion: { in: User::ROLES }

  after_initialize :set_role

  def last_sign_in_ago
    last_sign_in_at ? time_ago_in_words(last_sign_in_at) + " ago" : "-"
  end

  private

  def set_role
    self.role ||= User::ROLES.last
  end

  def timeout_in
    1.days
  end

end

class User < ApplicationRecord

  has_many :downloads
  has_many :communities, through: :memberships
  has_many :memberships, dependent: :destroy

  include ActionView::Helpers::DateHelper

  devise :rememberable, :timeoutable, :trackable, :omniauthable, omniauth_providers: [:linkedin]

  validates :email, uniqueness: true

  def last_sign_in_ago
    last_sign_in_at ? time_ago_in_words(last_sign_in_at) + " ago" : "-"
  end

  def membership(community)
    memberships.find_by(community: community)
  end

  def role(community)
    membership(community).role
  end

  def current_community
    membership = memberships.detect(&:current)
    membership ||= memberships.last
    membership ||= Membership.new
    membership.community
  end

  private

  def timeout_in
    1.days
  end

end

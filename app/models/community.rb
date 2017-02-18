class Community < ApplicationRecord

  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy

  validates :name, presence: true
  validates :slug, uniqueness: true

  scope :demo, -> {
    find_by(slug: "demo")
  }

  def demo?
    slug == "demo"
  end

end

class Community < ApplicationRecord

  SUBSCRIPTION_TYPES = {
    starter: {
      limits: {
        file_count: 30,
        file_size: 100 * 1024 * 1024,
        membership_count: 5
      }
    },
    standard: {
      limits: {
        file_count: 300,
        file_size: 3 * 1024 * 1024 * 1024,
        membership_count: 100
      }
    },
    premium: {
      limits: {
        file_count: false,
        file_size: 20 * 1024 * 1024 * 1024,
        membership_count: false
      }
    }
  }

  has_many :documents
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy

  validates :name, presence: true
  validates :slug, uniqueness: true
  validates :subscription_type, inclusion: {
    in: Community::SUBSCRIPTION_TYPES.keys.map(&:to_s)
  }

  scope :demo, -> {
    find_by(slug: "demo")
  }

  def demo?
    slug == "demo"
  end

  def file_count
    documents.length
  end

  def file_size
    documents.map(&:file_file_size).sum
  end

  def membership_counts
    memberships.select(&:active).length
  end

  def over_limit?(key)
    return false unless limits.key? key
    return false unless limits[key].present?
    return false unless respond_to? key
    send(key) < limits[key]
  end

  private

  def limits
    Community::SUBSCRIPTION_TYPES[subscription_type.to_sym][:limits]
  end

end

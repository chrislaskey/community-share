class Tag < ApplicationRecord

  belongs_to :community

  has_many :document_tags, dependent: :destroy
  has_many :documents, through: :document_tags

  validates :category, presence: true
  validates :community, presence: true
  validates :name, uniqueness: { scope: [:category, :community_id] }
  validates :slug, uniqueness: { scope: [:category, :community_id] }

  before_save :create_slug

  def create_slug
    self.slug = name.parameterize
  end

  def size
    documents.count
  end
end

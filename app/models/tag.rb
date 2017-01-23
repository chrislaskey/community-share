class Tag < ApplicationRecord

  has_many :document_tags, dependent: :destroy
  has_many :documents, through: :document_tags

  validates :name, uniqueness: {scope: :category}
  validates :slug, uniqueness: {scope: :category}
  validates :category, presence: true

  before_save :create_slug

  def create_slug
    self.slug = name.parameterize
  end
end

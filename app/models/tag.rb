class Tag < ApplicationRecord

  has_many :document_tags
  has_many :documents, through: :document_tags

  validates :name, uniqueness: true
  validates :slug, uniqueness: true

  before_save :create_slug

  def create_slug
    self.slug ||= name.parameterize
  end
end

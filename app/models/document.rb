class Document < ApplicationRecord

  belongs_to :user
  has_many :document_tags, dependent: :destroy
  has_many :downloads
  has_many :tags, through: :document_tags

  has_attached_file :file

  validates :name, uniqueness: true
  validates :slug, uniqueness: true
  validates :file, presence: true

  validates_attachment_content_type :file, content_type: [
    "application/msword",
    "application/pdf",
    "application/vnd.ms-excel",
    "application/vnd.ms-powerpoint",
    "application/vnd.openxmlformats-officedocument.presentationml.presentation",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "image/gif",
    "image/jpeg",
    "image/png"
  ]

  before_save :create_slug

  def create_slug
    self.slug = name.parameterize
  end

end

class Document < ApplicationRecord

  belongs_to :user
  has_many :document_tags, dependent: :destroy
  has_many :tags, through: :document_tags

  has_attached_file :file, {
    url: "/system/:hash.:extension",
    hash_secret: "yxeuriffeuhhvqzzqvchvavjgftjuoahrgbotbuxflkqvekffg"
  }

  validates :name, uniqueness: true
  validates :slug, uniqueness: true
  validates :file, presence: true

  validates_attachment_content_type :file, content_type: /application\/pdf/

  before_save :create_slug

  def create_slug
    self.slug = name.parameterize
  end

end

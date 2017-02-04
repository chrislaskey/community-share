class DocumentTag < ApplicationRecord

  belongs_to :document
  belongs_to :tag

  validates :document, presence: true
  validates :tag, presence: true

end

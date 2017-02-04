class Download < ApplicationRecord

  belongs_to :community
  belongs_to :document
  belongs_to :user

  validates :community, presence: true
  validates :document, presence: true
  validates :user, presence: true

end

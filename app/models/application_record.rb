class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  scope :in_community, ->(community) do
    where(community: community)
  end

end

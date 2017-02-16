require "rails_helper"

RSpec.describe User, type: :model do

  describe "associations" do
    it { is_expected.to have_many(:downloads) }
    it { is_expected.to have_many(:communities) }
    it { is_expected.to have_many(:memberships) }
  end

end

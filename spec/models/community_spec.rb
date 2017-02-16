require "rails_helper"

RSpec.describe Community, type: :model do

  describe "associations" do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:memberships) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:slug) }
  end

end

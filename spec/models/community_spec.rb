require "rails_helper"

RSpec.describe Community, type: :model do

  let(:community) { create(:community) }

  describe "associations" do
    it { is_expected.to have_many(:documents) }
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:users) }
  end

  describe "aliases" do
    it "has a subscriptions alias" do
      expect(community).to respond_to(:subscriptions)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:slug) }
  end

end

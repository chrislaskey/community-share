require "rails_helper"

RSpec.describe CommunitySubscription, type: :model do

  let(:community_subscription) { create(:community_subscription) }

  describe "associations" do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to belong_to(:community_level) }
  end

  describe "aliases" do
    it "has a level alias" do
      expect(community_subscription).to respond_to(:level)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:community) }
    it { is_expected.to validate_presence_of(:community_level) }
  end

end

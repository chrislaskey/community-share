require "rails_helper"

RSpec.describe Community, type: :model do

  let(:community) { create(:community) }

  describe "associations" do
    it { is_expected.to have_many(:documents) }
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:users) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:slug) }

    describe "subscription_type" do
      it "cannot be empty" do
        community.subscription_type = nil
        expect(community).not_to be_valid
      end

      it "cannot be any string" do
        community.subscription_type = "invalid string"
        expect(community).not_to be_valid
      end

      it "must be a valid name" do
        community.subscription_type = Community::SUBSCRIPTION_TYPES.keys.first
        expect(community).to be_valid
      end
    end
  end

end

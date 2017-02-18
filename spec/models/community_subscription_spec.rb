require "rails_helper"

RSpec.describe CommunitySubscription, type: :model do

  let(:subscription) { create(:community_subscription) }

  describe "associations" do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to belong_to(:community_level) }
  end

  describe "aliases" do
    it "has a level alias" do
      expect(subscription).to respond_to(:level)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:community) }
    it { is_expected.to validate_presence_of(:community_level) }
    it { is_expected.to validate_presence_of(:started_at) }
  end

  describe "before actions" do
    describe "close_active_subscription" do
      let(:community) { create(:community) }
      let(:open_subscription) { create(:community_subscription, community: community) }
      let(:new_subscription) { build(:community_subscription, community: community) }

      let(:other_community) { create(:community) }
      let(:other_open_subscription) { create(:community_subscription, community: other_community) }

      it "closes existing communities subscriptions on close" do
        expect(open_subscription.active).to be_truthy

        new_subscription.save

        expect(open_subscription.reload.active).to be_falsey
      end

      it "does not affect other community subscriptions" do
        expect(other_open_subscription.active).to be_truthy

        new_subscription.save

        expect(other_open_subscription.reload.active).to be_truthy
      end
    end
  end

  describe "active" do
    it "is true when ended_at is nil" do
      subscription.ended_at = nil
      expect(subscription.active).to be_truthy
    end

    it "is false when ended_at is present" do
      subscription.ended_at = Time.now
      expect(subscription.active).to be_falsey
    end
  end

end

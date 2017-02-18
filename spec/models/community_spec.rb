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

  describe "scopes" do
    describe "demo" do
      let!(:demo) { create(:community, slug: "demo") }

      it "looks up community by slug" do
        expect(Community.demo).to eq(demo)
      end
    end
  end

  describe "subscription" do
    let!(:closed_subscription) { create(:community_subscription, community: community, ended_at: Time.now) }
    let!(:active_subscription) { create(:community_subscription, community: community) }

    it "is the current active subscription" do
      expect(community.subscription).to eq(active_subscription)
    end
  end

  describe "level" do
    let!(:closed_subscription) { create(:community_subscription, community: community, ended_at: Time.now) }
    let!(:active_subscription) { create(:community_subscription, community: community) }

    it "is the current active subscription's community level" do
      expect(community.level).to eq(active_subscription.community_level)
    end
  end

  describe "demo?" do
    let(:demo_community) { create(:community, slug: "demo") }

    it "is true if slug is demo" do
      expect(demo_community.demo?).to be_truthy
    end

    it "is false if slug does not match" do
      expect(community.demo?).to be_falsey
    end
  end

  describe "summation methods" do
    let!(:document1) { create(:document, community: community) }
    let!(:document2) { create(:document, community: community) }
    let!(:membership1) { create(:membership, community: community) }
    let!(:membership2) { create(:membership, community: community) }

    describe "file_count" do
      it "matches for every document relation" do
        expect(community.file_count).to eq(2)
      end
    end

    describe "file_size" do
      it "matches for every document relation" do
        total = document1.file_file_size + document2.file_file_size

        expect(community.file_size).to eq(total)
      end
    end

    describe "membership_count" do
      it "matches for every document relation" do
        expect(community.membership_count).to eq(2)
      end
    end
  end

  describe "over_limit?" do
    let!(:subscription) { create(:community_subscription, community: community) }

    context "when under the limit" do
      it { expect(community.over_limit?(:file_size)).to be_falsey }
      it { expect(community.over_limit?(:file_count)).to be_falsey }
      it { expect(community.over_limit?(:membership_count)).to be_falsey }
    end

    context "when over the limit" do
      let!(:document1) { create(:document, community: community) }
      let!(:document2) { create(:document, community: community) }
      let!(:membership1) { create(:membership, community: community) }
      let!(:membership2) { create(:membership, community: community) }

      it { expect(community.over_limit?(:file_size)).to be_truthy }
      it { expect(community.over_limit?(:file_count)).to be_truthy }
      it { expect(community.over_limit?(:membership_count)).to be_truthy }
    end
  end

end

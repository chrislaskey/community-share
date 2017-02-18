require "rails_helper"

RSpec.describe CommunityLevel, type: :model do

  let(:community_level) { create(:community_level) }

  describe "associations" do
    it { is_expected.to have_many(:community_subscriptions) }
    it { is_expected.to have_many(:communities) }
  end

  describe "aliases" do
    it "has a subscriptions alias" do
      expect(community_level).to respond_to(:subscriptions)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:slug) }
    it { is_expected.to validate_presence_of(:file_count_limit) }
    it { is_expected.to validate_presence_of(:file_size_limit) }
    it { is_expected.to validate_presence_of(:membership_count_limit) }
  end

  describe "limit" do
    it "throws an exception if the key does not exist" do
      expect do
        community_level.limit("invalid")
      end.to raise_exception
    end

    it "returns the limit value" do
      expect(community_level.limit(:file_size)).to eq(community_level.file_size_limit)
    end
  end

end

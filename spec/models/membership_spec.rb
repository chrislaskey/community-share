require "rails_helper"

RSpec.describe Membership, type: :model do

  let(:membership) { create(:membership) }

  describe "associations" do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:community) }

    describe "role" do
      it "cannot be empty" do
        membership.role = nil
        expect(membership).not_to be_valid
      end

      it "cannot be any string" do
        membership.role = "invalid"
        expect(membership).not_to be_valid
      end

      it "must be in role" do
        membership.role = Membership::ROLES.sample
        expect(membership).to be_valid
      end
    end

    describe "user" do
      let(:user) { membership.user }
      let(:other_membership) { build(:membership, user: membership.user, community: membership.community) }

      it "cannot have more than one membership in a community" do
        expect(other_membership).not_to be_valid
      end
    end
  end

end

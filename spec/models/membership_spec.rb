require "rails_helper"

RSpec.describe Membership, type: :model do

  describe "associations" do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:community) }
  end

end

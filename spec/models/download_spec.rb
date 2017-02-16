require "rails_helper"

RSpec.describe Download, type: :model do

  describe "associations" do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to belong_to(:document) }
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:community) }
    it { is_expected.to validate_presence_of(:document) }
    it { is_expected.to validate_presence_of(:user) }
  end

end

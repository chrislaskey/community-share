require "rails_helper"

RSpec.describe DocumentTag, type: :model do

  describe "associations" do
    it { is_expected.to belong_to(:document) }
    it { is_expected.to belong_to(:tag) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:document) }
    it { is_expected.to validate_presence_of(:tag) }
  end

end

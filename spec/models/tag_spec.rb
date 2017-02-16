require "rails_helper"

RSpec.describe Tag, type: :model do

  describe "associations" do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to have_many(:document_tags) }
    it { is_expected.to have_many(:documents) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:community) }
  end

end

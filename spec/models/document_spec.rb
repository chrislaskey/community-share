require "rails_helper"

RSpec.describe Document, type: :model do

  describe "associations" do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:downloads) }
    it { is_expected.to have_many(:document_tags) }
    it { is_expected.to have_many(:tags) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:community) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:file) }

    it { is_expected.to validate_uniqueness_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

end

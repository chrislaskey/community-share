require "rails_helper"

RSpec.describe Tag, type: :model do

  let(:tag) { create(:tag) }

  describe "associations" do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to have_many(:document_tags) }
    it { is_expected.to have_many(:documents) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:community) }

    describe "name" do
      let(:other_tag) { build(:tag, name: tag.name, category: tag.category, community: tag.community) }

      it "cannot have the same name within the same category" do
        expect(other_tag).not_to be_valid
      end
    end

    describe "slug" do
      let(:other_tag) { build(:tag, slug: tag.slug, category: tag.category, community: tag.community) }

      it "cannot have the same slug within the same category" do
        expect(other_tag).not_to be_valid
      end
    end
  end

end

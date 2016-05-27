require 'spec_helper'

RSpec.describe ContentItem, type: :model do
  subject { build(:content_item) }

  context "validations" do
    it { is_expected.to validate_presence_of(:author_id) }
    it { is_expected.to validate_presence_of(:creator_id) }
    it { is_expected.to validate_presence_of(:content_type_id) }
  end

  context "associations" do
    it { is_expected.to belong_to(:content_type) }
    it { is_expected.to have_many(:field_items) }
  end
end

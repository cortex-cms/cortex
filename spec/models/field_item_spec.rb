require 'spec_helper'

RSpec.describe FieldItem, type: :model do
  subject { build(:field_item) }

  context "validations" do
    it { is_expected.to validate_presence_of(:field_id) }
    it { is_expected.to validate_presence_of(:content_item_id) }
  end

  context "associations" do
    it { is_expected.to belong_to(:field) }
    it { is_expected.to belong_to(:content_item) }
  end
end

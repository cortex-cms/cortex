require 'spec_helper'

RSpec.describe FieldItem, type: :model do
  # subject { build(:field_item) }

  xcontext "validations" do
    it { is_expected.to validate_presence_of(:field_id) }
    it { is_expected.to validate_presence_of(:content_item_id).on(:update) }

    context "against other models" do

    it "validates the data against the field type" do
      field = create(:field, field_type: "text_field_type", validations: { length: { minimum: 5 } })
      subject = build(:field_item, field: field, data: { text: "text" })
      expect(subject.valid?).to be false
      expect(subject.errors.full_messages.first).to eq("blah")
    end
  end

  xcontext "associations" do
    it { is_expected.to belong_to(:field) }
    it { is_expected.to belong_to(:content_item) }
  end
end

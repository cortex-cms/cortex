require 'spec_helper'

RSpec.describe FieldItem, type: :model do
  subject { build(:field_item) }

  context "validations" do
    xit { is_expected.to validate_presence_of(:field_id) }
    xit { is_expected.to validate_presence_of(:content_item_id).on(:update) }

    xit "validates the data against the field type" do
      field = create(:field, field_type: "text_field_type", validations: { length: { minimum: 5 } })
      subject = build(:field_item, field: field, data: { text: "text" })
      expect(subject.valid?).to be false
      expect(subject.errors.full_messages.first).to match(/is too short [(]minimum is 5 characters[)]/)
    end
  end

  context "associations" do
    xit { is_expected.to belong_to(:field) }
    xit { is_expected.to belong_to(:content_item) }
  end
end
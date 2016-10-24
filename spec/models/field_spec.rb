require 'spec_helper'

RSpec.describe Field, type: :model do
  subject { build(:field) }

  context "associations" do
    xit { is_expected.to belong_to(:content_type) }
    xit { is_expected.to have_many(:field_items) }
    xit { is_expected.to have_many(:content_items).through(:field_items) }
  end

  context "validations" do
    xit { is_expected.to validate_presence_of(:field_type) }

    context "content_type" do
      subject { build(:field, field_type: nil) }
      xit { is_expected.to validate_presence_of(:content_type) }
    end

    xit "checks that the field type is valid" do
      subject.field_type = "This_doesnt_exist"
      expect{ subject.valid? }.to raise_error(NameError)
      expect(subject.errors[:field_type]).to match_array(["must be an available field type"])
    end

    xit "checks the validations for its field type" do
      subject.field_type = TextFieldType.name.underscore
      subject.validations = { numericality: true }
      subject.valid?
      expect(subject.errors[:validations]).to match_array(["must be for specified type"])
    end
  end
end

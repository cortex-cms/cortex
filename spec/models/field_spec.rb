require 'spec_helper'

RSpec.describe Field, type: :model do
  subject { build(:field) }

  xcontext "validations" do
    it { is_expected.to validate_presence_of(:field_type) }
    it { is_expected.to validate_presence_of(:content_type) }

    it "checks that the field type is valid" do
      subject.field_type = "This_doesnt_exist"
      expect{ subject.valid? }.to raise_error(NameError)
      expect(subject.errors[:field_type]).to match_array(["must be an available field type"])
    end

    it "checks the validations for its field type" do
      subject.field_type = TextFieldType.name.underscore
      subject.validations = { numericality: true }
      subject.valid?
      expect(subject.errors[:validations]).to match_array(["must be for specified type"])
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:content_type) }
    it { is_expected.to have_many(:field_items) }
    it { is_expected.to have_many(:content_items).through(:field_items) }
  end
end

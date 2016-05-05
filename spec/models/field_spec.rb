require 'spec_helper'

RSpec.describe Field, type: :model do
  subject { build(:field) }

  context "validations" do
    it { is_expected.to validate_presence_of(:field_type) }
    it { is_expected.to validate_presence_of(:content_type) }
  end

  context "associations" do
    it { is_expected.to belong_to(:content_type) }
  end
end
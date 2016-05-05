require 'spec_helper'

RSpec.describe ContentType, type: :model do
  subject { build(:content_type) }

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:creator) }
  end

  context "associations" do
    it { is_expected.to belong_to(:creator).class_name("User") }
  end
end
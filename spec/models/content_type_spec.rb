require 'spec_helper'

RSpec.describe ContentType, type: :model do
  subject { build(:content_type) }

  context "validations" do
    xit { is_expected.to validate_presence_of(:name) }
    xit { is_expected.to validate_presence_of(:creator) }
  end

  context "associations" do
    xit { is_expected.to belong_to(:creator).class_name("User") }
    xit { is_expected.to have_many(:fields) }
    xit { is_expected.to have_many(:content_items) }
  end
end

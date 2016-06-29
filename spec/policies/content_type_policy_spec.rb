require 'spec_helper'

describe ContentTypePolicy do
  context "for an admin user" do
    subject { ContentTypePolicy.new(admin, content_type) }
    let(:content_type) { create(:content_type) }
    let(:admin) { create(:user) }
    let(:role) { Role.create(name: "admin") }

    before do
      admin.roles << role
    end

    it { should permit(:show) }
    it { should permit(:index) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should permit(:destroy) }
  end

  context "for a non admin user" do
    subject { ContentTypePolicy.new(user, content_type) }
    let(:content_type) { create(:content_type) }
    let(:user) { create(:user) }

    it { should_not permit(:show) }
    it { should_not permit(:index) }
    it { should_not permit(:create) }
    it { should_not permit(:new) }
    it { should_not permit(:update) }
    it { should_not permit(:edit) }
    it { should_not permit(:destroy) }
  end
end

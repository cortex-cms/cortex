require 'spec_helper'

describe ContentTypePolicy do
  context "for an superadmin user" do
    subject { ContentTypePolicy.new(admin, content_type) }
    let(:content_type) { create(:content_type) }
    let(:superadmin) { create(:user) }
    let(:role) { Role.create(name: "superadmin") }

    before do
      superadmin.roles << role
    end

    xit { should permit(:show) }
    xit { should permit(:index) }
    xit { should permit(:create) }
    xit { should permit(:new) }
    xit { should permit(:update) }
    xit { should permit(:edit) }
    xit { should permit(:destroy) }
  end

  context "for an admin user" do
    subject { ContentTypePolicy.new(admin, content_type) }
    let(:content_type) { create(:content_type) }
    let(:admin) { create(:user) }
    let(:role) { Role.create(name: "admin") }

    before do
      admin.roles << role
    end

    xit { should permit(:show) }
    xit { should permit(:index) }
    xit { should permit(:create) }
    xit { should permit(:new) }
    xit { should permit(:update) }
    xit { should permit(:edit) }
    xit { should permit(:destroy) }
  end

  context "for a non admin user" do
    subject { ContentTypePolicy.new(user, content_type) }
    let(:content_type) { create(:content_type) }
    let(:user) { create(:user) }

    xit { should_not permit(:show) }
    xit { should_not permit(:index) }
    xit { should_not permit(:create) }
    xit { should_not permit(:new) }
    xit { should_not permit(:update) }
    xit { should_not permit(:edit) }
    xit { should_not permit(:destroy) }
  end
end

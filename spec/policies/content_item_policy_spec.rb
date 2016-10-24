require 'spec_helper'

describe ContentItemPolicy do
  xcontext 'User is a Superadmin' do
    # subject { ContentItemPolicy.new(superadmin, content_item) }
    # let(:content_type) { create(:content_type) }
    # let(:content_item) { create(:content_item) }
    # let(:superadmin) { create(:user) }
    # let(:role) { Role.create(name: "superadmin") }

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
    xit { should permit(:can_publish) }
  end

  xcontext 'User is an Admin' do
    # subject { ContentItemPolicy.new(admin, content_item) }
    # let(:content_type) { create(:content_type) }
    # let(:content_item) { create(:content_item) }
    # let(:admin) { create(:user) }
    # let(:role) { Role.create(name: "admin") }

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
    xit { should permit(:can_publish) }
  end

  xcontext 'User is NOT an Admin' do
    # subject { ContentItemPolicy.new(user, content_item) }
    # let(:content_type) { create(:content_type) }
    # let(:content_item) { create(:content_item) }
    # let(:user) { create(:user) }

    xdescribe "#index?" do
      let(:role) { Role.create(name: "indexer") }
      let(:can_index) { Permission.create(name: "Index", resource_id: content_type.id, resource_type: "ContentType") }

      before do
        user.roles << role
      end

      context 'User has "Index" permission' do
        let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_index.id) }
        xit { should permit(:index) }
      end

      context 'User does not have "Index" permission' do
        xit { should_not permit(:index) }
      end
    end

    xdescribe "#new?" do
      let(:role) { Role.create(name: "newer") }
      let(:can_new) { Permission.create(name: "New", resource_id: content_type.id, resource_type: "ContentType") }

      before do
        user.roles << role
      end

      context 'User has "New" permission' do
        let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_new.id) }
        xit { should permit(:new) }
      end

      context 'User does not have "New" permission' do
        xit { should_not permit(:new) }
      end
    end

    xdescribe "#create?" do
      let(:role) { Role.create(name: "creator") }
      let(:can_create) { Permission.create(name: "Create", resource_id: content_type.id, resource_type: "ContentType") }

      before do
        user.roles << role
      end

      context 'User has "Create" permission' do
        let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_create.id) }
        xit { should permit(:create) }
      end

      context 'User does not have "Create" permission' do
        xit { should_not permit(:create) }
      end
    end

    xdescribe "#show?" do
      let(:role) { Role.create(name: "shower") }
      let(:can_show) { Permission.create(name: "Show", resource_id: content_type.id, resource_type: "ContentType") }

      before do
        user.roles << role
      end

      context 'User has "Show" permission' do
        let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_show.id) }
        it { should permit(:show) }
      end

      context 'User does not have "Show" permission' do
        it { should_not permit(:show) }
      end
    end

    xdescribe "#edit?" do
      let(:role) { Role.create(name: "editor") }
      let(:can_edit) { Permission.create(name: "Edit", resource_id: content_type.id, resource_type: "ContentType") }

      before do
        user.roles << role
      end

      context 'User has "Edit" permission' do
        let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_edit.id) }
        it { should permit(:edit) }
      end

      context 'User does not have "Edit" permission' do
        it { should_not permit(:edit) }
      end
    end

    xdescribe "#update?" do
      let(:role) { Role.create(name: "updater") }
      let(:can_update) { Permission.create(name: "Update", resource_id: content_type.id, resource_type: "ContentType") }

      before do
        user.roles << role
      end

      context 'User has "Update" permission' do
        let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_update.id) }
        it { should permit(:update) }
      end

      context 'User does not have "Update" permission' do
        it { should_not permit(:update) }
      end
    end

    xdescribe "#destroy?" do
      let(:role) { Role.create(name: "destroyer") }
      let(:can_destroy) { Permission.create(name: "Destroy", resource_id: content_type.id, resource_type: "ContentType") }

      before do
        user.roles << role
      end

      context 'User has "Destroy" permission' do
        let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_destroy.id) }
        it { should permit(:destroy) }
      end

      context 'User does not have "Destroy" permission' do
        it { should_not permit(:destroy) }
      end
    end

    xdescribe "#can_publish?" do
      let(:role) { Role.create(name: "publisher") }
      let(:can_publish_stuff) { Permission.create(name: "Can Publish", resource_id: content_type.id, resource_type: "ContentType") }

      before do
        user.roles << role
      end

      context 'User has "Can Publish" permission' do
        let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_publish_stuff.id) }
        it { should permit(:can_publish) }
      end

      context 'User does not have "Can Publish" permission' do
        it { should_not permit(:can_publish) }
      end
    end
  end
end

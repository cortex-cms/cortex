# require 'spec_helper'
#
# describe ContentItemPolicy do
#   context 'User is a Superadmin' do
#     subject { ContentItemPolicy.new(superadmin, content_item) }
#     let(:content_type) { create(:content_type) }
#     let(:content_item) { create(:content_item) }
#     let(:superadmin) { create(:user) }
#     let(:role) { Role.create(name: "superadmin") }
#
#     before do
#       superadmin.roles << role
#     end
#
#     it { should permit(:show) }
#     it { should permit(:index) }
#     it { should permit(:create) }
#     it { should permit(:new) }
#     it { should permit(:update) }
#     it { should permit(:edit) }
#     it { should permit(:destroy) }
#     it { should permit(:can_publish) }
#   end
#
#   context 'User is an Admin' do
#     subject { ContentItemPolicy.new(admin, content_item) }
#     let(:content_type) { create(:content_type) }
#     let(:content_item) { create(:content_item) }
#     let(:admin) { create(:user) }
#     let(:role) { Role.create(name: "admin") }
#
#     before do
#       admin.roles << role
#     end
#
#     it { should permit(:show) }
#     it { should permit(:index) }
#     it { should permit(:create) }
#     it { should permit(:new) }
#     it { should permit(:update) }
#     it { should permit(:edit) }
#     it { should permit(:destroy) }
#     it { should permit(:can_publish) }
#   end
#
#   context 'User is NOT an Admin' do
#     subject { ContentItemPolicy.new(user, content_item) }
#     let(:content_type) { create(:content_type) }
#     let(:content_item) { create(:content_item) }
#     let(:user) { create(:user) }
#
#     describe "#index?" do
#       let(:role) { Role.create(name: "indexer") }
#       let(:can_index) { Permission.create(name: "Index", resource_id: content_type.id, resource_type: "ContentType") }
#
#       before do
#         user.roles << role
#       end
#
#       context 'User has "Index" permission' do
#         let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_index.id) }
#         it { should permit(:index) }
#       end
#
#       context 'User does not have "Index" permission' do
#         it { should_not permit(:index) }
#       end
#     end
#
#     describe "#new?" do
#       let(:role) { Role.create(name: "newer") }
#       let(:can_new) { Permission.create(name: "New", resource_id: content_type.id, resource_type: "ContentType") }
#
#       before do
#         user.roles << role
#       end
#
#       context 'User has "New" permission' do
#         let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_new.id) }
#         it { should permit(:new) }
#       end
#
#       context 'User does not have "New" permission' do
#         it { should_not permit(:new) }
#       end
#     end
#
#     describe "#create?" do
#       let(:role) { Role.create(name: "creator") }
#       let(:can_create) { Permission.create(name: "Create", resource_id: content_type.id, resource_type: "ContentType") }
#
#       before do
#         user.roles << role
#       end
#
#       context 'User has "Create" permission' do
#         let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_create.id) }
#         it { should permit(:create) }
#       end
#
#       context 'User does not have "Create" permission' do
#         it { should_not permit(:create) }
#       end
#     end
#
#     describe "#show?" do
#       let(:role) { Role.create(name: "shower") }
#       let(:can_show) { Permission.create(name: "Show", resource_id: content_type.id, resource_type: "ContentType") }
#
#       before do
#         user.roles << role
#       end
#
#       context 'User has "Show" permission' do
#         let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_show.id) }
#         it { should permit(:show) }
#       end
#
#       context 'User does not have "Show" permission' do
#         it { should_not permit(:show) }
#       end
#     end
#
#     describe "#edit?" do
#       let(:role) { Role.create(name: "editor") }
#       let(:can_edit) { Permission.create(name: "Edit", resource_id: content_type.id, resource_type: "ContentType") }
#
#       before do
#         user.roles << role
#       end
#
#       context 'User has "Edit" permission' do
#         let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_edit.id) }
#         it { should permit(:edit) }
#       end
#
#       context 'User does not have "Edit" permission' do
#         it { should_not permit(:edit) }
#       end
#     end
#
#     describe "#update?" do
#       let(:role) { Role.create(name: "updater") }
#       let(:can_update) { Permission.create(name: "Update", resource_id: content_type.id, resource_type: "ContentType") }
#
#       before do
#         user.roles << role
#       end
#
#       context 'User has "Update" permission' do
#         let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_update.id) }
#         it { should permit(:update) }
#       end
#
#       context 'User does not have "Update" permission' do
#         it { should_not permit(:update) }
#       end
#     end
#
#     describe "#destroy?" do
#       let(:role) { Role.create(name: "destroyer") }
#       let(:can_destroy) { Permission.create(name: "Destroy", resource_id: content_type.id, resource_type: "ContentType") }
#
#       before do
#         user.roles << role
#       end
#
#       context 'User has "Destroy" permission' do
#         let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_destroy.id) }
#         it { should permit(:destroy) }
#       end
#
#       context 'User does not have "Destroy" permission' do
#         it { should_not permit(:destroy) }
#       end
#     end
#
#     describe "#can_publish?" do
#       let(:role) { Role.create(name: "publisher") }
#       let(:can_publish_stuff) { Permission.create(name: "Can Publish", resource_id: content_type.id, resource_type: "ContentType") }
#
#       before do
#         user.roles << role
#       end
#
#       context 'User has "Can Publish" permission' do
#         let(:rp) { RolePermission.create(role_id: role.id, permission_id: can_publish_stuff.id) }
#         it { should permit(:can_publish) }
#       end
#
#       context 'User does not have "Can Publish" permission' do
#         it { should_not permit(:can_publish) }
#       end
#     end
#   end
# end

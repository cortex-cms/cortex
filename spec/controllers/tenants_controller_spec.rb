require 'spec_helper'

describe TenantsController do

  before { log_in }
  before { request.env['HTTP_ACCEPT'] = 'application/json' }

  describe 'GET #index' do
    let(:organization) { create(:organization) }
    before { get :index }

    it 'should return an array of tenants' do
      assigns(:tenants).should =~ organization.self_and_descendants
    end
  end

  describe 'GET #hierarchy' do
    let(:user) { create(:user) }
    let(:organizations) { [create(:organization, user: user), create(:organization, user: user)] }
    before { get :hierarchy }

    it 'should return root tenants (organizations)' do
      assigns(:tenants).should =~ organizations
    end
  end

  describe 'GET #show' do
    let(:tenant) { create(:tenant) }
    before { get :show, id: tenant.id }

    it 'should find the correct tenant' do
      assigns(:tenant).should eq(tenant)
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'should create a new tenant' do
        expect{ post :create, tenant: attributes_for(:tenant) }.to change(Tenant, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'should NOT create a new tenant' do
        expect { post :create, tenant: attributes_for(:invalid_tenant) }.to raise_error(ActiveRecord::RecordInvalid)
        # expect{ post :create, tenant: attributes_for(:invalid_tenant) }.to_not change(Tenant, :count).by(1)
      end
    end
  end

  describe 'PUT #update' do
    let(:tenant) { create(:tenant) }

    context 'with valid attributes' do
      it 'should find the correct tenant' do
        put :update, id: tenant, tenant: attributes_for(:tenant)
        assigns(:tenant).should eq(tenant)
      end

      it "should change the tenant's attributes" do
        put :update, id: tenant, tenant: attributes_for(:tenant, name: 'modified', subdomain: 'modified')
        tenant.reload
        tenant.name.should eq('modified')
        tenant.subdomain.should eq('modified')
      end
    end

    context 'with invalid attributes' do
      let(:tenant) { create(:tenant) }

      it 'should find the correct tenant' do
        put :update, id: tenant, tenant: attributes_for(:invalid_tenant)
        assigns(:tenant).should eq(tenant)
      end

      it "should NOT change the tenant's attributes" do
        put :update, id: tenant, tenant: attributes_for(:tenant, name: nil, subdomain: 'modified')
        tenant.reload
        tenant.subdomain.should_not eq('modified')
        tenant.subdomain.should eq('tenant')
      end
    end
  end

  describe 'GET #by_organization' do
    let(:user) { create(:user) }
    let(:organizations) {  [create(:organization, user: user), create(:organization, user: user)] }
    let(:selected_org) { organizations[0] }

    context 'when including root' do
      before { get :by_organization, org_id: selected_org.id, include_root: true }

      it 'should include organization' do
        assigns(:tenants).should include(selected_org)
      end
    end

    context 'when not including root' do
      before { get :by_organization, org_id: selected_org.id, include_root: false }

      it 'should not include organization' do
        assigns(:tenants).should_not include(selected_org)
      end
    end
  end

  describe 'GET #hierarchy_by_organization' do
    let(:user) { create(:user) }
    let(:organizations) {  [create(:organization, user: user), create(:organization, user: user)] }
    let(:selected_org) { organizations[0] }

    context 'when including root' do
      before { get :hierarchy_by_organization, org_id: selected_org.id, include_root: true }

      it 'should include organization' do
        assigns(:tenants).should eq([selected_org])
      end
    end

    context 'when not including root' do
      before { get :hierarchy_by_organization, org_id: selected_org.id, include_root: false }

      it 'should not include organization' do
        assigns(:tenants).should eq(selected_org.children)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the tenant' do
      tenant = create(:tenant)
      expect{ delete :destroy, id: tenant }.to change(Tenant, :count).by(-1)
    end
  end
end

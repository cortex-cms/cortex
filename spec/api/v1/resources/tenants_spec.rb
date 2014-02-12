require 'spec_helper'
require 'api_v1_helper'

describe API::Resources::Tenants do

  let(:user) { create(:user) }

  before do
    login_as user
  end

  describe 'GET /tenants/:id' do

    let(:tenant) { create(:tenant) }

    it 'should return the correct tenant' do
      get "/api/v1/tenants/#{tenant.id}"
      response.should be_success
      response.body.should represent(API::Entities::Tenant, tenant)
    end
  end

  describe 'POST /tenants' do

    context 'with valid attributes' do
      it 'should create a new tenant' do
        expect{ post '/api/v1/tenants', attributes_for(:tenant) }.to change(Tenant, :count).by(1)
        response.should be_success
        response.body.should represent(API::Entities::Tenant, Tenant.last)
      end
    end

    context 'with invalid attributes' do
      it 'should NOT create a new tenant' do
        expect{ post '/api/v1/tenants', attributes_for(:tenant, name: nil) }.to_not change(Tenant, :count).by(1)
        response.should_not be_success
      end
    end
  end

  describe 'PUT /tenants/:id' do

    context 'with valid attributes' do
      it 'should update the tenant' do
        tenant = create(:tenant)
        tenant.name += ' updated'
        expect{ put "/api/v1/tenants/#{tenant.id}", tenant.to_json, application_json }.to_not change(Tenant, :count).by(1)
        response.should be_success
        response.body.should represent(API::Entities::Tenant, tenant)
      end
    end

    context 'with invalid attributes' do
      it 'should NOT update the tenant' do
        tenant = create(:tenant)
        expect{ put "/api/v1/tenants/#{tenant.id}", {name: nil}.to_json, application_json }.to_not change(Tenant, :count).by(1)
        response.should_not be_success
      end
    end
  end

  describe 'DELETE /tenants/:id' do

    it 'should delete the tenant' do
      tenant = create(:tenant)
      expect{ delete "/api/v1/tenants/#{tenant.id}" }.to change(Tenant, :count).by(-1)
      response.should be_success
    end

    it 'should NOT delete a non-existent tenant' do
      tenant = create(:tenant)
      expect{ delete "/api/v1/tenants/#{tenant.id+1}" }.to_not change(Tenant, :count).by(-1)
      response.should_not be_success
    end
  end
end

require 'spec_helper'
require 'api_v1_helper'

describe SPEC_API::Resources::Credentials, :type => :request do

  let(:user) { create(:user, :admin) }

  before do
    login_as user
  end

  describe 'GET /applications/:application_id/credentials/:id' do

    let(:credentials) { create(:credentials) }

    it 'should be a success' do
      get "/api/v1/applications/#{credentials.owner.id}/credentials"
      expect(response).to be_success
    end

    it 'should return the correct credentials' do
      get "/api/v1/applications/#{credentials.owner.id}/credentials/#{credentials.id}"
      expect(response.body).to represent(SPEC_API::V1::Entities::Credential, credentials)
    end
  end

  describe 'POST /applications/:application_id/credentials/:id' do

    let(:application) { create(:application) }

    context 'with valid attributes' do

      it 'should be a success' do
        post "/api/v1/applications/#{application.id}/credentials", attributes_for(:credentials)
        expect(response).to be_success
      end

      it 'should increase the number of credentials by 1' do
        expect{ post "/api/v1/applications/#{application.id}/credentials", attributes_for(:credentials) }.to change{application.credentials.count}.by(1)
      end

      it 'should create a new credential' do
        post "/api/v1/applications/#{application.id}/credentials", attributes_for(:credentials)
        expect(response.body).to represent(SPEC_API::V1::Entities::Credential, application.credentials.last)
      end
    end

    context 'with invalid attributes' do
      it 'should NOT create a new application' do
        expect{ post "/api/v1/applications/#{application.id}/credentials", attributes_for(:credentials, name: nil) }.to_not change{application.credentials.count}
      end
      it 'should not be a success' do
        post "/api/v1/applications/#{application.id}/credentials", attributes_for(:credentials, name: nil)
        expect(response).not_to be_success
      end
    end
  end

  describe 'PUT /applications/:application_id/credentials/:id' do

    context 'with valid attributes' do
      let(:credentials) { create(:credentials) }

      it 'should update the credential' do
        credentials.name += ' updated'
        put "/api/v1/applications/#{credentials.owner.id}/credentials/#{credentials.id}", credentials.to_json, application_json
        expect(response.body).to represent(SPEC_API::V1::Entities::Credential, credentials)
      end
      it 'should be a success' do
        credentials.name += ' updated'
        put "/api/v1/applications/#{credentials.owner.id}/credentials/#{credentials.id}", credentials.to_json, application_json
        expect(response).to be_success
      end
      it 'should not create a new credential' do
        credentials.name += ' updated'
        expect{ put "/api/v1/applications/#{credentials.owner.id}/credentials/#{credentials.id}", credentials.to_json, application_json }.to_not change{credentials.owner.credentials.count}
      end
    end

    context 'with invalid attributes' do
      let(:credentials) { create(:credentials) }

      it 'should NOT update the credential' do
        credentials
        expect{ put "/api/v1/applications/#{credentials.owner.id}/credentials/#{credentials.id}", {name: nil}.to_json, application_json }.to_not change{credentials.owner.credentials.count}
      end

      it 'should not be a success' do
        put "/api/v1/applications/#{credentials.owner.id}/credentials/#{credentials.id}", {name: nil}.to_json, application_json
        expect(response).not_to be_success
      end
    end
  end

  describe 'DELETE /applications/:application_id/credentials/:id' do

    context 'with an existing credential' do
      let(:credentials) { create(:credentials) }

      it 'should be a success' do
        delete "/api/v1/applications/#{credentials.owner.id}/credentials/#{credentials.id}"
        expect(response).to be_success
      end

      it 'should delete the credential' do
        credentials
        expect{ delete "/api/v1/applications/#{credentials.owner.id}/credentials/#{credentials.id}" }.to change{credentials.owner.credentials.count}.by(-1)
      end
    end
  end
end

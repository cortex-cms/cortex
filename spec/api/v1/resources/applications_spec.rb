require 'spec_helper'
require 'api_v1_helper'

describe API::Resources::Applications, :type => :request do

  let(:user) { create(:user, :admin) }

  before do
    login_as user
  end

  describe 'GET /applications/:id' do

    let(:application) { create(:application) }

    it 'should be a success' do
      get "/api/v1/applications/#{application.id}"
      expect(response).to be_success

    end

    it 'should return the correct application' do
      get "/api/v1/applications/#{application.id}"
      expect(response.body).to represent(API::Entities::Application, application)
    end
  end

  describe 'POST /applications' do

    context 'with valid attributes' do

      it 'should be a success' do
        post '/api/v1/applications', attributes_for(:application)
        expect{ post '/api/v1/applications', attributes_for(:application) }.to change(Application, :count).by(1)
        expect(response).to be_success
      end

      it 'should create a new application' do
        post '/api/v1/applications', attributes_for(:application)
        expect(response.body).to represent(API::Entities::Application, Application.last)
      end

      it 'should change the application count by 1' do
        expect{ post '/api/v1/applications', attributes_for(:application) }.to change(Application, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'should NOT create a new application' do
        expect{ post '/api/v1/applications', attributes_for(:application, name: nil) }.to_not change(Application, :count)
      end
      it 'should not be a success' do
        post '/api/v1/applications', attributes_for(:application, name: nil)
        expect(response).not_to be_success
      end
    end
  end

  describe 'PUT /applications/:id' do

    context 'with valid attributes' do
      let(:application) { create(:application) }

      it 'should update the application' do
        application.name += ' updated'
        put "/api/v1/applications/#{application.id}", application.to_json, application_json
        expect(response.body).to represent(API::Entities::Application, application)
      end
      it 'should be a success' do
        application.name += ' updated'
        put "/api/v1/applications/#{application.id}", application.to_json, application_json
        expect(response).to be_success
      end
      it 'should not create a new application' do
        application.name += ' updated'
        expect{ put "/api/v1/applications/#{application.id}", application.to_json, application_json }.to_not change(Application, :count)
      end
    end

    context 'with invalid attributes' do
      let(:application) { create(:application) }

      it 'should NOT update the application' do
        expect{ put "/api/v1/applications/#{application.id}", {name: nil}.to_json, application_json }.to_not change(Application, :count)
      end

      it 'should not be a success' do
        put "/api/v1/applications/#{application.id}", {name: nil}.to_json, application_json
        expect(response).not_to be_success
      end
    end
  end

  describe 'DELETE /applications/:id' do

    context 'with an existing application' do
      let(:application) { create(:application) }

      it 'should be a success' do
        delete "/api/v1/applications/#{application.id}"
        expect(response).to be_success
      end

      it 'should delete the application' do
        expect{ delete "/api/v1/applications/#{application.id}" }.to change(Application, :count).by(-1)
      end
    end

    context 'with a nonexistent application' do
      let(:application) { create(:application) }

      it 'should not be a success' do
        delete "/api/v1/applications/#{application.id+1}"
        expect(response).not_to be_success
      end

      it 'should not change the application count' do
        expect{ delete "/api/v1/applications/#{application.id+1}" }.to_not change(Application, :count)
      end
    end
  end
end

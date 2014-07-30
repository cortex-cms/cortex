require 'spec_helper'
require 'api_v1_helper'

describe API::Resources::Users, :type => :request do

  describe 'GET /users/me' do

    let(:user) { create(:user) }

    it 'should get the current user if authorized' do
      login_as user
      get '/api/v1/users/me'
      expect(response).to be_success
      expect(response.body).to represent(API::Entities::User, user, { full: true })
    end

    it 'should NOT get the current user if unauthorized' do
      get '/api/v1/users/me'
      expect(response.status).to eq(401)
    end
  end
end

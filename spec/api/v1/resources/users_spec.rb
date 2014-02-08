require 'spec_helper'
require 'api_v1_helper'

describe API::Resources::Users do

  describe 'GET /users/me' do

    let(:user) { create(:user) }

    it 'should get the current user if authorized' do
      login_as user
      get '/api/v1/users/me'
      response.status.should == 200
      response.body.should represent(API::Entities::User, user)
    end

    it 'should NOT get the current user if unauthorized' do
      get '/api/v1/users/me'
      response.status.should == 401
    end
  end
end

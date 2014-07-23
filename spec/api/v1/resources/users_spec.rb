require 'spec_helper'
require 'api_v1_helper'

describe API::Resources::Users do

  let(:user) { create(:user) }

  describe 'GET /users/me' do

    it 'should get the current user if authorized' do
      login_as user
      get '/api/v1/users/me'
      response.should be_success
      response.body.should represent(API::Entities::User, user)
    end

    it 'should NOT get the current user if unauthorized' do
      get '/api/v1/users/me'
      response.status.should == 401
    end
  end

  describe 'GET /users/:id/author' do

    it 'should get the related author' do
      login_as user
      get "/api/v1/users/#{user.id}/author"
      response.should be_success
      response.body.should represent(API::Entities::Author, user.author)
    end
  end

  describe 'PUT /users/:id/author' do

    it 'should save the related author' do
      login_as user
      author = user.author
      author.firstname = 'Frank'
      expect{ put "/api/v1/users/#{user.id}/author", author.to_json, application_json }.to_not change(Author, :count).by(1)
      response.should be_success
      response.body.should represent(API::Entities::Author, author)
    end
  end
end

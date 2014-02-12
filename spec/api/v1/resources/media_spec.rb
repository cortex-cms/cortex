require 'spec_helper'
require 'api_v1_helper'

describe API::Resources::Media do

  let(:user) { create(:user) }

  before do
    login_as user
  end

  describe 'GET /media/:id' do

    let(:media) { create(:media) }

    it 'should return the correct media' do
      get "/api/v1/media/#{media.id}"
      response.should be_success
      response.body.should represent(API::Entities::Media, media)
    end
  end

  describe 'POST /media' do

    context 'with valid attributes' do
      it 'should create new media' do
        expect{ post '/api/v1/media', media: attributes_for(:media) }.to change(Media, :count).by(1)
        response.should be_success
        response.body.should represent(API::Entities::Media, Media.last)
      end
    end
  end

  describe 'PUT /media/:id' do

    context 'with valid attributes' do
      it 'should update media' do
        media = create(:media)
        media.name += ' updated'
        expect{ put "/api/v1/media/#{media.id}", {media: media}.to_json, application_json }.to_not change(Media, :count).by(1)
        response.should be_success
        response.body.should represent(API::Entities::Media, media)
      end
    end
  end

  describe 'DELETE /media/:id' do

    it 'should delete media' do
      media = create(:media)
      expect{ delete "/api/v1/media/#{media.id}" }.to change(Media, :count).by(-1)
      response.should be_success
    end

    it 'should NOT delete non-existent media' do
      media = create(:media)
      expect{ delete "/api/v1/media/#{media.id+1}" }.to_not change(Media, :count).by(-1)
      response.should_not be_success
    end
  end
end

require 'spec_helper'
require 'api_v1_helper'

describe API::Resources::Media, elasticsearch: true do

  let(:user) { create(:user, :admin) }

  before do
    login_as user
    Media.__elasticsearch__.create_index! index: Media.index_name

  end

  describe 'GET /media' do

    it 'returns an empty array if there is no media' do
      get '/api/v1/media'
      response.should be_success
      JSON.parse(response.body).should == []
    end

    it 'should return two media items' do
      2.times { create(:media) }
      get '/api/v1/media'
      response.should be_success
      JSON.parse(response.body).count.should == 2
    end

    it 'should return paginated results' do
      5.times { create(:media) }
      get '/api/v1/media?per_page=2'
      response.should be_success
      JSON.parse(response.body).count.should == 2
      response.headers['X-Total-Items'].should == '5'
      response.headers['Content-Range'].should == 'media 0-1:2/5'
    end

    # TODO: Enable when Ben's media resource is merged in.
    it 'should allow search on q' do
      skip("Waiting on Ben's reworked media resource")
      media_1 = create(:media)
      media_2 = create(:media, name: "RANDOM")
      Media.import({refresh: true})
      get '/api/v1/media?q=RANDOM'
      response.should be_success
      pp JSON.parse(response.body)
      JSON.parse(response.body).count.should == 1
    end
  end

  describe 'GET /media/:id' do

    let(:media) { create(:media) }

    it 'should return the correct media' do
      get "/api/v1/media/#{media.id}"
      response.should be_success
      response.body.should represent(API::Entities::Media, media, { full: true })
    end
  end

  describe 'POST /media' do

    context 'with valid attributes' do
      it 'should create new media' do
        expect{ post '/api/v1/media', media: attributes_for(:media) }.to change(Media, :count).by(1)
        response.should be_success
        response.body.should represent(API::Entities::Media, Media.last, { full: true })
      end
    end
  end

  describe 'PUT /media/:id' do

    context 'with valid attributes' do
      it 'should update media' do
        media = create(:media)
        media.name += ' updated'
        expect{ put "/api/v1/media/#{media.id}", media.to_json, application_json }.to_not change(Media, :count).by(1)
        response.should be_success
        response.body.should represent(API::Entities::Media, media, { full: true })
      end

      it 'should only update allowed parameters' do
        media = create(:media)
        media.name += ' updated'
        media.taxon = 'BreakingTaxon'
        expect { put "/api/v1/media/#{media.id}", media.to_json, application_json }.to_not change(Media, :count).by(1)
        response.should be_success
        response_obj = JSON.parse(response.body)
        response_obj["name"].should eq "#{media.name}"
        response_obj["taxon"].should_not eq "BreakingTaxon"
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

    it 'should not delete consumed media' do
      media = create(:media)
      post = create(:post)
      post.featured_media = media
      post.save
      expect { delete "/api/v1/media/#{media.id}" }.not_to change(Media, :count).by(-1)
      expect(response.status).to eq(409)
    end
  end
  after do
    Media.__elasticsearch__.client.indices.delete index: Media.index_name
  end
end

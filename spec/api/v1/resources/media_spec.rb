require 'spec_helper'
require 'api_v1_helper'

describe SPEC_API::Resources::Media, type: :request, elasticsearch: true do

  let(:user) { create(:user, :admin) }

  before do
    login_as user
    Media.__elasticsearch__.create_index! index: Media.index_name
  end

  describe 'GET /media' do

    it 'returns an empty array if there is no media' do
      get '/api/v1/media'
      expect(response).to be_success
      expect(JSON.parse(response.body)).to eq([])
    end

    it 'should return two media items' do
      2.times { create(:media, user: user) }
      get '/api/v1/media'
      expect(response).to be_success
      expect(JSON.parse(response.body).count).to eq(2)
    end

    it 'should return paginated results' do
      5.times { create(:media, user: user) }
      get '/api/v1/media?per_page=2'
      expect(response).to be_success
      expect(JSON.parse(response.body).count).to eq(2)
      expect(response.headers['X-Total-Items']).to eq('5')
      expect(response.headers['Content-Range']).to eq('media 0-1:2/5')
    end

    it 'should allow search on q' do
      media_1 = create(:media, user: user)
      media_2 = create(:media, name: "RANDOM", user: user)
      Media.import({refresh: true})
      get '/api/v1/media?q=RANDOM'
      expect(response).to be_success
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe 'GET /media/tags' do

    it 'returns an empty array if there are no tags' do
      get '/api/v1/media/tags'
      expect(response).to be_success
      expect(JSON.parse(response.body)).to eq([])
    end

    it 'should return the correct number of tags' do
      5.times { |i| create(:media, tag_list: ["tag_#{i}"], user: user) }
      get '/api/v1/media/tags'
      expect(response).to be_success
      result = JSON.parse(response.body)
      expect(result.count).to eq(5)
    end

    it 'should return popular tags in order' do
      5.times { |i| create(:media, tag_list: ['popular_tag', "tag_#{i}"], user: user) }
      get '/api/v1/media/tags?popular=true'
      expect(response).to be_success
      result = JSON.parse(response.body)
      expect(result.count).to eq(6)
      expect(result[0]).to include('name' => 'popular_tag', 'count' => 5)
    end
  end

  describe 'GET /media/:id' do

    let(:media) { create(:media, user: user) }

    it 'should return the correct media' do
      get "/api/v1/media/#{media.id}"
      expect(response).to be_success
      expect(response.body).to represent(SPEC_API::Entities::Media, media, { full: true })
    end
  end

  describe 'POST /media' do

    context 'with valid attributes' do
      it 'should create new media' do
        expect{ post '/api/v1/media', media: attributes_for(:media) }.to change(Media, :count).by(1)
        expect(response).to be_success
        expect(response.body).to represent(SPEC_API::Entities::Media, Media.last, { full: true })
      end
    end
  end

  describe 'PUT /media/:id' do

    context 'with valid attributes' do
      it 'should update media' do
        media = create(:media, user: user)
        media.name += ' updated'
        expect{ put "/api/v1/media/#{media.id}", media.to_json, application_json }.to_not change(Media, :count)
        expect(response).to be_success
        expect(response.body).to represent(SPEC_API::Entities::Media, media, { full: true })
      end

      it 'should only update allowed parameters' do
        media = create(:media, user: user)
        media.name += ' updated'
        media.taxon = 'BreakingTaxon'
        expect { put "/api/v1/media/#{media.id}", media.to_json, application_json }.to_not change(Media, :count)
        expect(response).to be_success
        response_obj = JSON.parse(response.body)
        expect(response_obj["name"]).to eq "#{media.name}"
        expect(response_obj["taxon"]).not_to eq "BreakingTaxon"
      end
    end
  end

  describe 'DELETE /media/:id' do

    it 'should delete media' do
      media = create(:media, user: user)
      expect{ delete "/api/v1/media/#{media.id}" }.to change(Media, :count).by(-1)
      expect(response).to be_success
    end

    it 'should NOT delete non-existent media' do
      media = create(:media, user: user)
      expect{ delete "/api/v1/media/#{media.id+1}" }.to_not change(Media, :count)
      expect(response).not_to be_success
    end

    it 'should not delete consumed media' do
      media = create(:media, user: user)
      post = create(:post, user: user)
      post.featured_media = media
      post.save
      expect { delete "/api/v1/media/#{media.id}" }.to_not change(Media, :count)
      expect(Media.exists? media.id).to be_truthy
      expect(response.status).to eq(409)
    end
  end
  after do
    Media.__elasticsearch__.client.indices.delete index: Media.index_name
  end
end

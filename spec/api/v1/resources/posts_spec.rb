require 'spec_helper'
require 'api_v1_helper'

describe API::Resources::Posts, elasticsearch: true do

  let(:user) { create(:user, :admin) }

  before do
    login_as user
    Post.__elasticsearch__.create_index! index: Post.index_name
  end

  describe 'GET /posts' do

    it 'returns an empty array if there are no posts' do
      get '/api/v1/posts'
      response.should be_success
      JSON.parse(response.body).should == []
    end

    it 'should return two posts' do
      post_1 = create(:post)
      post_2 = create(:post)
      get '/api/v1/posts'
      response.should be_success
      JSON.parse(response.body).count.should == 2
    end

    it 'should return paginated results' do
      5.times { create(:post) }
      get '/api/v1/posts?per_page=2'
      response.should be_success
      JSON.parse(response.body).count.should == 2
      response.headers['X-Total-Items'].should == '5'
      response.headers['Content-Range'].should == 'posts 0-1:2/5'
    end

    it 'should allow search on q' do
      post_1 = create(:post)
      post_2 = create(:post, title: "Test Post for testing queries.")
      Post.import({refresh: true})
      get '/api/v1/posts?q=Test'
      response.should be_success
      JSON.parse(response.body).count.should == 1
    end

  end

  describe 'GET /posts/:id' do

    it 'should return the correct post' do
      post = create(:post)
      get "/api/v1/posts/#{post.id}"
      response.should be_success
      response.body.should represent(API::Entities::Post, post)
    end
  end

  describe 'POST /posts' do

    context 'with valid attributes' do
      it 'should create a new post' do
        expect{ post '/api/v1/posts', attributes_for(:post) }.to change(Post, :count).by(1)
        response.should be_success
        response.body.should represent(API::Entities::Post, Post.last)
      end
    end

    context 'with invalid attributes' do
      it 'should NOT create a new post' do
        expect{ post '/api/v1/posts', attributes_for(:post, title: nil) }.to_not change(Post, :count).by(1)
        response.should_not be_success
      end
    end

    context 'with featured media' do
      it 'should create a new post' do
        expect{ post '/api/v1/posts', build(:post, :with_featured_media).to_json, application_json }.to change(Post, :count).by(1)
        response.should be_success
        response.body.should represent(API::Entities::Post, Post.last)
      end

      it 'should include the featured media in associated media' do
        post = build(:post, :with_featured_media)
        post '/api/v1/posts', post.to_json, application_json
        Post.last.media.should include(post.featured_media)
      end
    end
  end

  describe 'PUT /posts/:id' do

    context 'with valid attributes' do
      it 'should update the post' do
        post = create(:post)
        post.title += ' updated'
        expect{ put "/api/v1/posts/#{post.id}",  post.to_json, application_json }.to_not change(Post, :count).by(1)
        response.should be_success
        response.body.should represent(API::Entities::Post, post)
      end
    end

    context 'with invalid attributes' do
      it 'should NOT update the post' do
        post = create(:post)
        expect{ put "/api/v1/posts/#{post.id}", {title: nil}.to_json, application_json }.to_not change(Post, :count).by(1)
        response.should_not be_success
      end
    end

    context 'with featured media' do
      it 'should update the post' do
        post = create(:post, :with_featured_media)
        post.title += ' updated'
        expect{ put "/api/v1/posts/#{post.id}",  post.to_json, application_json }.to_not change(Post, :count).by(1)
        response.should be_success
        response.body.should represent(API::Entities::Post, post)
      end

      it 'should include the featured media in associated media' do
        post = create(:post, :with_featured_media)
        post.featured_media = build(:post, :with_featured_media).featured_media
        expect{ put "/api/v1/posts/#{post.id}",  post.to_json, application_json }.to_not change(Post, :count).by(1)
        Post.find(post.id).media.should include(post.featured_media)
      end
    end
  end

  describe 'DELETE /posts/:id' do

    it 'should delete the post' do
      post = create(:post)
      expect{ delete "/api/v1/posts/#{post.id}" }.to change(Post, :count).by(-1)
      response.should be_success
    end

    it 'should NOT delete a non-existent post' do
      post = create(:post)
      expect{ delete "/api/v1/posts/#{post.id+1}" }.to_not change(Post, :count).by(-1)
      response.should_not be_success
    end
  end

  after do
    Post.__elasticsearch__.client.indices.delete index: Post.index_name
  end
end

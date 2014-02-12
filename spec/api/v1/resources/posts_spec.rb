require 'spec_helper'
require 'api_v1_helper'

describe API::Resources::Posts do

  let(:user) { create(:user) }

  before do
    login_as user
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
end

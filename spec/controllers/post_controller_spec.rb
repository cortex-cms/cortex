require 'spec_helper'

describe PostsController do

  before { log_in }
  before { request.env['HTTP_ACCEPT'] = 'application/json' }

  let(:post) { create(:post) }

  describe 'GET #index' do

    before { get :index }

    it 'should return an array of posts' do
      assigns(:posts).should =~ [post]
    end
  end

  describe 'GET #show' do

    before { get :show, id: post.id }

    it 'should find the correct post' do
      assigns(:post).should eq(post)
    end
  end

=begin
  describe 'POST #create' do

    context 'with valid attributes' do
      it 'should create a new post' do
        expect{ post :create, post: attributes_for(:post) }.to change(Post,:count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'should NOT create a new asset' do
        expect(create(:post, :invalid)).to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'should find the correct tenant'
      it 'should create a new asset'
    end

    context 'with invalid attributes' do
      it 'should find the correct tenant'
      it 'should NOT create a new asset'
    end
  end
=end

  describe 'DELETE #destroy' do
    it 'should delete the post' do
      post = create(:post)
      expect{ delete :destroy, id: post }.to change(Post, :count).by(-1)
    end
  end

end

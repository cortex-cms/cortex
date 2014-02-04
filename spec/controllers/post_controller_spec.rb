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

end

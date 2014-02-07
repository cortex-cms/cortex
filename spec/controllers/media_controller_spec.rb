require 'spec_helper'

describe MediaController do

  before { log_in }
  before { request.env['HTTP_ACCEPT'] = 'application/json' }

  let(:media) { create(:media, :image) }

  describe 'GET #index' do

    before { get :index }

    it 'should return an array of media' do
      assigns(:media).should =~ [media]
    end
  end

  describe 'GET #show' do
    before { get :show, id: media.id }

    it 'should find the correct media' do
      assigns(:media).should eq(media)
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the media' do
      media = create(:media, :image)
      expect{ delete :destroy, id: media }.to change(Media, :count).by(-1)
    end
  end
end

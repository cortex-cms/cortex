require 'spec_helper'

describe AssetsController do

  before { log_in }
  before { request.env['HTTP_ACCEPT'] = 'application/json' }

  describe 'GET #index' do
    let(:asset) { create(:asset) }
    before { get :index }

    it 'should return an array of assets' do
      assigns(:assets).should =~ [asset]
    end
  end

  describe 'GET #show' do
    let(:asset) { create(:asset) }
    before { get :show, id: asset.id }

    it 'should find the correct asset' do
      assigns(:asset).should eq(asset)
    end
  end
=begin
  describe 'POST #create' do

    context 'with valid attributes' do
      it 'should create a new asset' do
        expect{ post :create, asset: attributes_for{:asset} }.to change(Asset, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'should NOT create a new asset' do
        expect{ post :create, asset: attributes_for{:invalid_asset} }.to raise_error(ActiveRecord::RecordInvalid)
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
    it 'should delete the asset' do
      asset = create(:asset)
      expect{ delete :destroy, id: asset }.to change(Asset, :count).by(-1)
    end
  end
end

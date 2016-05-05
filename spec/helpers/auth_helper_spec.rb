require 'rails_helper'
require 'rack/test'

def app
  Cortex::Application
end

RSpec.describe do
  include Rack::Test::Methods
  before :each do
    api_double = double("api")
    allow(api_double).to receive(:request) do
      last_request
    end

    allow(api_double).to receive(:response) do
      last_response
    end

    allow(api_double).to receive(:env) do
      last_request.env
    end

    api_double.extend Helpers::AuthHelper::HelperMethods
    @api = api_double
  end

  describe '#current_user' do
    it 'returns the current user' do
      get '/'
      expect(@api.current_user).to be_a(User)
    end
  end

  describe "#current_user!" do
    context 'with anonymous user' do
      before :each do
        get '/'
        allow(@api.current_user).to receive(:anonymous?).and_return true
      end

      it 'should return call unauthorized!' do
        allow(@api).to receive(:unauthorized!)
        @api.current_user!
        expect(@api).to have_received(:unauthorized!)
      end
    end

    context 'with non-anonymous user' do
      before :each do
        get '/'
        allow(@api.current_user).to receive(:anonymous?).and_return false
      end

      it 'should return the current user' do
        expect(@api.current_user!).to be_a User
      end
    end
  end

  describe '#find_access_token' do
    context 'with no access token' do
      it 'should call Doorkeeper.authenticate' do
        get '/'
        doorkeeper_spy = spy('doorkeeper')
        @api.find_access_token(doorkeeper_spy)
        expect(@api.find_access_token).to equal(doorkeeper_spy)
      end
    end

    context 'with access token' do
      before :each do
        @api.instance_variable_set(:@access_token, "token")
      end

      it 'should return the access token' do
        get '/'
        expect(@api.find_access_token).to match /token/
      end
    end
  end

  describe 'authenticate!' do
    context 'with current user' do
      before :each do
        allow(@api).to receive(:current_user).and_return(User.new)
      end
      it 'should be nil' do
        get '/'
        expect(@api.authenticate!).to be_nil
      end
    end

    context 'with no current user' do
      before :each do
        allow(@api).to receive(:current_user).and_return(nil)
      end

      it 'should call unauthorized!' do
        get '/'
        allow(@api).to receive(:unauthorized!)
        @api.authenticate!
        expect(@api).to have_received(:unauthorized!)
      end
    end
  end

  describe '#authorize!' do
    context 'with abilities allowed' do
      before :each do
        allow(@api).to receive(:abilities)
        allow(@api.abilities).to receive(:allowed?).and_return(true)
      end

      it 'should return nil' do
        get '/'
        expect(@api.authorize!(nil, nil)).to be_nil
      end
    end

    context 'with abilities not allowed' do
      before :each do
        allow(@api).to receive(:abilities)
        allow(@api.abilities).to receive(:allowed?).and_return(false)
      end

      it 'should call forbidden!' do
        get '/'
        allow(@api).to receive(:forbidden!)
        @api.authorize!(nil, nil)
        expect(@api).to have_received(:forbidden!)
      end
    end
  end

end

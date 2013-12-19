require 'spec_helper'

describe UsersController do

  before { request.env['HTTP_ACCEPT'] = 'application/json' }

  describe 'GET #me' do
    context 'when authorized' do

      before { log_in }
      before { get :me }

      it 'should return current user' do
        expect(response).to be_success
      end
    end

    context 'when unauthorized' do

      before { get :me }

      it 'should not return current user' do
        expect(response.status).to eq(401)
      end
    end
  end

end

require 'spec_helper'

describe UsersController do

  describe '#me' do
    context 'when authorized' do

      before { log_in }
      before { get :me, format: :json }

      it 'should return current user' do
        expect(response).to be_success
      end
    end

    context 'when unauthorized' do

      before { get :me, format: :json }

      it 'should not return current user' do
        expect(response.status).to eq(401) 
      end
    end
  end

end

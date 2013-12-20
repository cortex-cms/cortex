require 'spec_helper'

describe OrganizationsController do

  before { log_in }
  before { request.env['HTTP_ACCEPT'] = 'application/json' }

  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:organizations) { [create(:organization, user: user), create(:organization, user: user)] }
    before { get :index }

    it 'should return an array of organizations' do
      assigns(:organizations).should =~ organizations
    end
  end
end
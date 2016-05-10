require 'spec_helper'
require 'api_v1_helper'

describe SPEC_API::Resources::ContentItem, type: :request, elasticsearch: true do
  let(:user) { create(:user, :admin) }
  let(:author) { create(:user) }

  before(:each) do
    login_as user
  end

  describe 'GET /content_items' do
    before do
      3.times { create(:content_item, author: user) }
    end

    it "returns all content_items" do
      get '/api/v2/content_items'
      expect(response).to be_success
      expect(JSON.parse(response.body).count).to eq 3
    end

    it "returns paginated results" do
      get '/api/v1/content_items?per_page=2'
      expect(response).to be_success
      expect(JSON.parse(response.body).count).to eq(2)
    end
  end
end

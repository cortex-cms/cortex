require 'spec_helper'
require 'api_v1_helper'

describe SPEC_API::Resources::ContentItems, type: :request do

  let(:user) { create(:user, :admin) }
  let(:field) { create(:field) }
  let(:content_type) { field.content_type }

  before(:each) do
    login_as user
  end

  context 'with valid attributes' do
    let(:valid_content_item) {
      {
        publish_state: "draft",
        author_id: user.id,
        creator_id: user.id,
        content_type_id: content_type.id,
        field_items_attributes: [
          {
            field_id: field.id,
            text: "abc123"
          }
        ]
      }
    }

    it 'should create a new content item' do
      expect{ post '/api/v1/content_items', valid_content_item }.to change(ContentItem, :count).by(1)
      expect(response).to be_success
      expect(response.body).to represent(SPEC_API::Entities::ContentItem, ContentItem.last, { full: true })
      content_item = ContentItem.last
      expect(content_item.content_type.name).to eq content_type.name
      expect(content_item.field_items.first.field_id).to eq field.id
    end
  end

  context 'with invalid attributes' do
    it 'should NOT create a new content item' do
      expect{ post '/api/v1/content_items', attributes_for(:content_item, creator: nil) }.to_not change(ContentItem, :count)
      expect(response).not_to be_success
    end
  end
end

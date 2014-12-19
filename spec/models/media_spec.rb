require 'spec_helper'

RSpec.describe Media, type: :model do

  it "should create media with valid parameters" do
    media = create(:media, :image)
    expect(media.attachment_content_type).to eq('image/jpeg')
  end

  it "should allow deletion of unconsumed media" do
    media = create(:media)
    expect(media.destroy).to be_truthy
  end

  it "should not allow deletion of consumed media" do
    media = create(:media)
    post = create(:post)
    post.featured_media = media
    post.save
    expect {media.destroy}.to raise_error
  end

  describe 'find_by_tenant_id' do
    let (:user) { create(:user) }
    let (:other_user) { create(:user) }
    let (:media) { create(:media, user: user) }
    let (:other_media) { create(:media, user: other_user) }

    it 'should return the post from the first tenant' do
      this_media = Media.find media.id
      that_media = Media.find other_media.id
      expect(Media.find_by_tenant_id(user.tenant.id)).to include(this_media)
    end

    it 'should not return the post from the other tenant' do
      this_media = Media.find media.id
      that_media = Media.find other_media.id
      expect(Media.find_by_tenant_id(user.tenant.id)).not_to include(that_media)
    end
  end
end

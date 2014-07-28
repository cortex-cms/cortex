require 'spec_helper'

RSpec.describe Media, type: :model do

  it "should create media with valid parameters" do
    media = create(:media, :image)
    expect(media.attachment_content_type).to eq('image/jpeg')
  end

  it "should allow deletion of unconsumed media" do
    media = create(:media)
    expect(media.destroy).to be_true
  end

  it "should not allow deletion of consumed media" do
    media = create(:media)
    post = create(:post)
    post.featured_media = media
    post.save
    expect(media.destroy).to be_false
  end
end
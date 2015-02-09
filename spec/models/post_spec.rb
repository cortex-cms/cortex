require 'spec_helper'

RSpec.describe Post, type: :model do

  describe "find_by_id_or_slug" do
    it "should find by ID" do
      post = create(:post)
      expect(Post.find_by_id_or_slug(post.id).id).to eq(post.id)
    end

    it "should find by slug" do
      post = create(:post)
      post2 = create(:post, slug: "#{post.id}-slug")
      expect(Post.find_by_id_or_slug(post2.slug).id).to eq(post2.id)
    end
  end

  describe 'find_by_tenant_id' do
    let (:user) { create(:user) }
    let (:other_user) { create(:user) }
    let (:post) { create(:post, user: user) }
    let (:other_post) { create(:post, user: other_user) }

    it 'should return the post from the first tenant' do
      this_post = Post.find post.id
      that_post = Post.find other_post.id
      expect(Post.find_by_tenant_id(user.tenant.id)).to include(this_post)
    end

    it 'should not return the post from the other tenant' do
      this_post = Post.find post.id
      that_post = Post.find other_post.id
      expect(Post.find_by_tenant_id(user.tenant.id)).not_to include(that_post)
    end
  end

  describe Post.published do
    before :all do
      @unpublished_post = create(:post, draft: true)
      @future_post = create(:post, published_at: Time.now + 2.days)
      @expired_post =  create(:post, expired_at: Time.now - 2.days)
      @post = create(:post)
    end

    it { is_expected.not_to include(@unpublished_post, @future_post, @expired_post) }
    it { is_expected.to include(@post) }
  end
end

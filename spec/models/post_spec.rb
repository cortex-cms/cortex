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

  describe '#published?' do
    let (:user) { create(:user) }
    let (:post) { create(:post) }

    context 'Post is Expired' do
      let (:expired_post) { create(:post, user: user, expired_at: Time.now - 2.days) }

      it 'should return false' do
        expect(expired_post.published?).to be_falsey
      end
    end

    context 'Post is a Draft' do
      let (:draft_post) { create(:post, user: user, draft: true) }

      it 'should return false' do
        expect(draft_post.published?).to be_falsey
      end
    end

    context 'Post will be published in the future' do
      let (:future_post) { create(:post, user: user, published_at: Time.now + 2.days) }

      it 'should return false' do
        expect(future_post.published?).to be_falsey
      end
    end

    context 'Post is Active' do
      it 'should return true' do
        expect(post.published?).to be_truthy
      end
    end
  end

  describe '#expired?' do
    let (:user) { create(:user) }
    let (:post) { create(:post, user: user, expired_at: Time.now + 2.days) }
    let (:expired_post) { create(:post, user: user, expired_at: Time.now - 2.days) }

    context 'expired_at is nil' do
      context 'Post is expired' do
        it 'should return true' do
          expect(expired_post.expired?).to be_truthy
        end
      end

      context 'Post is not expired' do
        it 'should return false' do
          expect(post.expired?).to be_falsey
        end
      end
    end

    context 'expired_at is not nil' do
      let (:other_post) { create(:post, user: user, expired_at: nil) }

      it 'should return false' do
        expect(other_post.expired?).to be_falsey
      end
    end
  end

  describe '#pending?' do
    let (:user) { create(:user) }
    let (:post) { create(:post, user: user, published_at: Time.now - 2.days) }
    let (:future_post) { create(:post, user: user, published_at: Time.now + 2.days) }

    context 'published_at is not nil' do
      context 'Post is pending publish' do
        it 'should return true' do
          expect(future_post.pending?).to be_truthy
        end
      end

      context 'Post is not pending publish' do
        it 'should return false' do
          expect(post.pending?).to be_falsey
        end
      end
    end

    context 'published_at is nil' do
      let (:other_post) { create(:post, user: user, published_at: nil) }

      it 'should return false' do
        expect(other_post.pending?).to be_falsey
      end
    end
  end

end

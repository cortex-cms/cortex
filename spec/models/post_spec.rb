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
end

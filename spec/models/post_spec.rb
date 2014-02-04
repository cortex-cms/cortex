require 'spec_helper'

describe Post do

  context 'post model' do

    it 'creates a post successfully' do
      post = create(:post)
      post.save
    end

  end
end
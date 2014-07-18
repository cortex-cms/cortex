require 'spec_helper'

describe HasGravatar do
  context 'author model' do
    it 'should provide Gravatar icon URLs' do
      author = build(:author, email: 'talentsolutionstechnology@careerbuilder.com')
      author.avatars[:default].should include('211d03ded8ca5767c12c5f80f9cb6ad2')
    end

    it 'should return the default URL if there is no email' do
      author = build(:author, email: nil)
      author.avatars[:default].should include('00000000000000000000000000000000')
    end
  end
end

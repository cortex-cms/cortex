require 'spec_helper'

describe HasGravatar, :type => :model do
  context 'author model' do
    it 'should provide Gravatar icon URLs' do
      author = build(:author, email: 'talentsolutionstechnology@careerbuilder.com')
      expect(author.avatars[:default]).to include('211d03ded8ca5767c12c5f80f9cb6ad2')
    end
  end
end

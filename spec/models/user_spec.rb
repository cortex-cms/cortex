require 'spec_helper'

describe User do
  it 'has a valid factory' do
    create(:user).should be_valid
  end

  context 'validity' do
    let(:user) { create(:user) }

    it 'is invalid without a name' do
      user.name = nil
      user.should_not be_valid
    end
      
    it 'is invalid without an email' do
      user.email = nil
      user.should_not be_valid
    end
  end

  context 'authentication' do

    let(:user) { create(:user) }

    it 'should return a valid user' do
      User.authenticate(user.name, user.password).should eq(user)
    end

    it 'should NOT return an invalid user' do
      User.authenticate(user.name, user.password + 'fake').should eq(nil)
    end
  end
end

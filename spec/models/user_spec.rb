require 'spec_helper'

describe User do
  it 'has a valid factory' do
    create(:user).should be_valid
  end

  context 'validity' do
    let(:user) { create(:user) }

=begin
    it 'is invalid without a name' do
      user.name = nil
      user.should_not be_valid
    end
=end
      
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

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(30)       not null
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  tenant_id       :integer          not null
#

require 'spec_helper'

describe User do

  it 'should create an author for the user when created' do
    user = create(:user)
    user.author.firstname.should == user.firstname
    user.author.lastname.should == user.lastname
    user.author.email.should == user.email
  end
end

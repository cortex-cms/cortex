require 'spec_helper'

describe User do
  it 'should have a valid factory' do
    user = create(:user)
    user.should_not be_nil
  end
end

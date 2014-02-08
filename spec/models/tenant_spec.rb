require 'spec_helper'

describe Tenant do
  it 'should have a valid factory' do
    user = create(:tenant)
    user.should_not be_nil
  end
end

require 'spec_helper'

describe Abilities::UserAbility do

=begin
  context 'admin user' do

    it 'should give admin user the ability to view and update self' do
      admin_user = create(:user, :admin)
      abilities = Abilities::UserAbility.allowed(admin_user, admin_user)
      expect(abilities).to eq([:view, :update])
    end

    it 'should give admin user the ability to view and create tenant' do
      admin_user = create(:user, :admin)
      abilities = Abilities::UserAbility.allowed(admin_user, Tenant)
      expect(abilities).to eq([:view, :create])
    end
  end

  context 'guest user' do

    it 'should give guest user the ability to view and edit self' do
      guest_user = create(:user)
      abilities = Abilities::UserAbility.allowed(guest_user, guest_user)
      expect(abilities).to eq([:view, :update])
    end

    it 'should deny guest user abilities when trying to view/edit tenant' do
      guest_user = create(:user)
      abilities = Abilities::UserAbility.allowed(guest_user, Tenant)
      expect(abilities).to eq([])
    end
  end
=end

end

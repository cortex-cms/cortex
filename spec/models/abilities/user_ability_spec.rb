require 'spec_helper'

describe Abilities::UserAbility, :type => :model do

  begin
    context 'admin' do

      it 'should have the ability to view, update and delete self' do
        admin = create(:user, :admin)
        abilities = Abilities::UserAbility.allowed(admin, admin)
        expect(abilities).to eq([:view, :update, :delete])
      end

      it 'should have the ability to view and create tenant' do
        admin = create(:user, :admin)
        abilities = Abilities::UserAbility.allowed(admin, Tenant)
        expect(abilities).to eq([:view, :create])
      end

      it 'should have the ability to view and create webpages' do
        admin = create(:user, :admin)
        abilities = Abilities::UserAbility.allowed(admin, Webpage)
        expect(abilities).to eq([:view, :create])
      end
    end

    context 'user' do

      it 'should have the ability to view, edit and delete self' do
        user = create(:user)
        abilities = Abilities::UserAbility.allowed(user, user)
        expect(abilities).to eq([:view, :update, :delete])
      end

      it 'should NOT have the ability to view or create tenant' do
        user = create(:user)
        abilities = Abilities::UserAbility.allowed(user, Tenant)
        expect(abilities).to eq([])
      end

      it 'should NOT have the ability to create webpages' do
        user = create(:user)
        abilities = Abilities::UserAbility.allowed(user, Webpage)
        expect(abilities).to eq([:view])
      end
    end
  end

end

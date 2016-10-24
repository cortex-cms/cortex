require 'spec_helper'

describe Abilities::Ability, :type => :model do

  begin
    context 'User' do
      it 'should have the ability to view, edit and delete self' do
        user = create(:user)
        abilities = Abilities::Ability.allowed(user, user)
        expect(abilities).to eq([:view, :update, :delete])
      end

      it 'should NOT have the ability to view or create tenant' do
        user = create(:user)
        abilities = Abilities::Ability.allowed(user, Tenant)
        expect(abilities).to eq([])
      end

      it 'should NOT have the ability to create webpages' do
        user = create(:user)
        abilities = Abilities::Ability.allowed(user, Webpage)
        expect(abilities).to eq([:view])
      end
    end

    context 'Application' do
      it 'should have the ability to view, create, update, delete' do
        app = create(:application, write: true)
        abilities = Abilities::Ability.allowed(app, nil)
        expect(abilities).to eq([:view, :create, :update, :delete])
      end
    end

    context 'Anything Else' do
      it 'should have no abilities' do
        post = create(:post)
        abilities = Abilities::Ability.allowed(post, post)
        expect(abilities).to eq([])
      end
    end
  end

end

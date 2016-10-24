require 'spec_helper'

describe Abilities::ApplicationAbility, :type => :model do

  begin
    context 'Can Write' do
      it 'should have the ability to view, create, update, delete' do
        app = create(:application, write: true)
        abilities = Abilities::ApplicationAbility.allowed(app)
        expect(abilities).to eq([:view, :create, :update, :delete])
      end
    end

    context 'Can NOT Write' do
      it 'should have the ability to view only' do
        app = create(:application, write: false)
        abilities = Abilities::ApplicationAbility.allowed(app)
        expect(abilities).to eq([:view])
        expect(abilities.length).to eq(1)
      end
    end
  end

end

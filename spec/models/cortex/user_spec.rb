require 'rails_helper'

module Cortex
  RSpec.describe User, type: :model do

    let (:user) { create :cortex_user }

    describe "#gravatar" do
      let (:gravatar_user) { create :cortex_user, email: "test@cortexcms.org" }

      it "should return correct URI without scheme" do
        expect(gravatar_user.gravatar).to eq "//www.gravatar.com/avatar/8d718f299ed398b82cd27bba96a77996"
      end
    end

  end
end

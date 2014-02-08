module Abilities
  class Ability
    class << self
      def allowed(user, subject)
        return [] if user.nil?

        if user.kind_of? User
          Abilities::UserAbility.allowed(user, subject)
        else
          []
        end
      end
    end
  end
end

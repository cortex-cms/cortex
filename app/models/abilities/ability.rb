module Abilities
  class Ability
    class << self
      def allowed(user, subject)
        return [] if user.nil?

        if user.kind_of? User
          Abilities::UserAbility.allowed(user, subject)
        elsif user.kind_of? Application
          Abilities::ApplicationAbility.allowed()
        else
          []
        end
      end
    end
  end
end

module Abilities
  class ApplicationAbility
    class << self
      def allowed
        [:view]
      end

    end
  end
end

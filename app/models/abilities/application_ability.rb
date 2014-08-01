module Abilities
  class ApplicationAbility
    class << self
      def allowed(app)
        if app.write
          %w[:view :create :update :delete]
        else
          [:view]
        end
      end

    end
  end
end

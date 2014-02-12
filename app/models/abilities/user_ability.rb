module Abilities
  class UserAbility
    class << self
      def allowed(user, subject)
        abilities = []

        if subject.kind_of? User
          abilities << user_abilities(user, subject)
        end

        abilities
      end

      private
      def user_abilities(user, subject_user)
        abilities = []

        # Users can view and edit themselves
        if subject_user.id == user.id
          abilities << [
              :view,
              :edit
          ]
        end
      end
    end
  end
end
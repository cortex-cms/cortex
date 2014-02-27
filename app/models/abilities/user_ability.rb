module Abilities
  class UserAbility
    class << self
      def allowed(user, subject)
        abilities = []

        if subject.is_a? Class
          if subject == User;   abilities << user_class_abilities(user) end
          if subject == Tenant; abilities << tenant_class_abilities(user) end
          if subject == Post;   abilities << post_class_abilities(user) end
          if subject == Media;  abilities << media_class_abilities(user) end
        else
          if subject.kind_of? User;   abilities << user_abilities(user, subject) end
          if subject.kind_of? Tenant; abilities << tenant_abilities(user, subject) end
          if subject.kind_of? Post;   abilities << post_abilities(user, subject) end
          if subject.kind_of? Media;  abilities << media_abilities(user, subject) end
        end

        abilities
      end

      private
      def user_abilities(user, subject_user)
        abilities = []

        # Users can view and edit themselves
        if subject_user.id == user.id
          abilities << [:view, :update]
        end
      end

      def user_class_abilities(user)
        [:view, :create]
      end

      def tenant_abilities(user, tenant)
        [:view, :update, :delete]
      end

      def tenant_class_abilities(user)
        [:view, :create]
      end

      def post_abilities(user, post)
        [:view, :update, :delete]
      end

      def post_class_abilities(user)
        [:view, :create]
      end

      def media_abilities(user, media)
        [:view, :update, :delete]
      end

      def media_class_abilities(user)
        [:view, :create]
      end
    end
  end
end
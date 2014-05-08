module Abilities
  class UserAbility
    class << self
      def allowed(user, subject)
        abilities = []

        if user.is_admin?
          if subject.is_a? Class
            if subject == User;   abilities += user_class_abilities(user)
            elsif subject == Tenant; abilities += tenant_class_abilities(user)
            elsif subject == Post;   abilities += post_class_abilities(user)
            elsif subject == Media;  abilities += media_class_abilities(user)
            elsif subject == Category; abilities += category_class_abilities(user)
            elsif subject == Tag; abilities += tag_class_abilities(user)
            end
          else
            if subject.kind_of? User;   abilities += user_abilities(user, subject)
            elsif subject.kind_of? Tenant; abilities += tenant_abilities(user, subject)
            elsif subject.kind_of? Post;   abilities += post_abilities(user, subject)
            elsif subject.kind_of? Media;  abilities += media_abilities(user, subject)
            end
          end
        else
          abilities += regular_abilities(user, subject)
        end

        abilities
      end

      private

      def regular_abilities(user, subject)
        abilities = []

        # Guest can view themselves
        if subject.kind_of? User; abilities += user_abilities(user, subject) end
        abilities
      end

      def user_abilities(user, user_subject)
        abilities = []

        # Users can view and edit themselves
        if user_subject.id == user.id
          abilities += [:view, :update]
        end

        abilities
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

      def category_class_abilities(user)
        [:view]
      end

      def tag_class_abilities(user)
        [:view]
      end

    end
  end
end
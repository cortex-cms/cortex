module Abilities
  class UserAbility
    class << self
      def allowed(user, subject)
        abilities = []

        if subject.is_a? Class
          if subject == User; abilities += user_class_abilities(user)
          elsif subject == Tenant; abilities += tenant_class_abilities(user)
          elsif subject == Localization; abilities += localization_class_abilities(user)
          elsif subject == Locale; abilities += locale_class_abilities(user)
          elsif subject == Application; abilities += application_class_abilities(user);
          elsif subject == ContentType; abilities += content_type_class_abilities(user);
          elsif subject == ContentItem; abilities += content_item_class_abilities(user);
          end
        else
          if subject.kind_of? User; abilities += user_abilities(user, subject)
          elsif subject.kind_of? Tenant; abilities += tenant_abilities(user, subject)
          elsif subject.kind_of? Localization; abilities += localization_abilities(user, subject)
          elsif subject.kind_of? Locale; abilities += locale_abilities(user, subject)
          elsif subject.kind_of? Application; abilities += application_abilities(user, subject)
          elsif subject.kind_of? ContentType; abilities += content_type_abilities(user, subject)
          elsif subject.kind_of? ContentItem; abilities += content_item_abilities(user, subject)
          end
        end

        abilities
      end

      private

      def user_abilities(user, user_subject)
        abilities = []

        # Users can view/modify/delete themselves, admins can for all
        if user_subject.id == user.id || user.is_admin?
          abilities += [:view, :update, :delete]
        end

        abilities
      end

      def user_class_abilities(user)
        if user.is_admin?
          [:view, :create]
        else
          []
        end
      end

      def tenant_abilities(user, tenant)
        if user.is_admin?
          [:view, :update, :delete]
        else
          []
        end
      end

      def tenant_class_abilities(user)
        if user.is_admin?
          [:view, :create]
        else
          []
        end
      end

      def localization_abilities(user, localization)
        [:view, :update, :delete]
      end

      def localization_class_abilities(user)
        [:view, :create]
      end

      def locale_abilities(user, locale)
        [:view, :update, :delete]
      end

      def locale_class_abilities(user)
        [:view, :create]
      end

      def application_abilities(user, application)
        if user.is_admin? || user.tenant == application.tenant
          [:view, :update, :delete]
        else
          []
        end
      end

      def application_class_abilities(user)
        if user.is_admin?
          [:view, :create]
        else
          []
        end
      end

      def content_type_abilities(user, snippet)
        [:view]
      end

      def content_type_class_abilities(user)
        [:view]
      end

      def content_item_abilities(user, snippet)
        [:view, :create]
      end

      def content_item_class_abilities(user)
        [:view, :create]
      end
    end
  end
end

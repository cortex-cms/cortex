module Abilities
  class UserAbility
    class << self
      def allowed(user, subject)
        abilities = []

        if subject.is_a? Class
          if subject == User; abilities += user_class_abilities(user)
          elsif subject == Tenant; abilities += tenant_class_abilities(user)
          elsif subject == Post; abilities += post_class_abilities(user)
          elsif subject == Media; abilities += media_class_abilities(user)
          elsif subject == Category; abilities += category_class_abilities(user)
          elsif subject == Localization; abilities += localization_class_abilities(user)
          elsif subject == Locale; abilities += locale_class_abilities(user)
          elsif subject == Application; abilities += application_class_abilities(user);
          elsif subject == BulkJob; abilities += bulk_job_class_abilities(user);
          elsif subject == Document; abilities += document_class_abilities(user);
          elsif subject == Webpage; abilities += webpage_class_abilities(user);
          elsif subject == Snippet; abilities += snippet_class_abilities(user);
          end
        else
          if subject.kind_of? User; abilities += user_abilities(user, subject)
          elsif subject.kind_of? Tenant; abilities += tenant_abilities(user, subject)
          elsif subject.kind_of? Post; abilities += post_abilities(user, subject)
          elsif subject.kind_of? Media; abilities += media_abilities(user, subject)
          elsif subject.kind_of? Localization; abilities += localization_abilities(user, subject)
          elsif subject.kind_of? Locale; abilities += locale_abilities(user, subject)
          elsif subject.kind_of? Application; abilities += application_abilities(user, subject)
          elsif subject.kind_of? BulkJob; abilities += bulk_job_abilities(user, subject)
          elsif subject.kind_of? Document; abilities += document_abilities(user, subject)
          elsif subject.kind_of? Webpage; abilities += webpage_abilities(user, subject)
          elsif subject.kind_of? Snippet; abilities += snippet_abilities(user, subject)
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

      def bulk_job_abilities(user, bulk_job)
        [:view, :update, :delete]
      end

      def bulk_job_class_abilities(user)
        [:view, :create]
      end

      def document_abilities(user, document)
        [:view, :update, :delete]
      end

      def document_class_abilities(user)
        [:view, :create]
      end

      def webpage_abilities(user, webpage)
        if user.is_admin?
          [:view, :update, :delete]
        else
          [:view]
        end
      end

      def webpage_class_abilities(user)
        if user.is_admin?
          [:view, :create]
        else
          []
        end
      end

      def snippet_abilities(user, snippet)
        [:view, :update, :delete]
      end

      def snippet_class_abilities(user)
        [:view, :create]
      end
    end
  end
end

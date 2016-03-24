module V1
  module Resources
    class Localizations < Grape::API
      helpers Helpers::ParamsHelper

      resource :localizations do
        include Grape::Kaminari
        helpers Helpers::LocalizationHelper

        paginate per_page: 25

        desc 'Show all localizations', { entity: ::V1::Entities::Localization, nickname: 'showAllLocalizations' }
        get do
          require_scope! :'view:localizations'
          authorize! :view, ::Localization

          @localizations = ::Localization.order(created_at: :desc)

          ::V1::Entities::Localization.represent paginate(@localizations)
        end

        desc 'Get localization', { entity: ::V1::Entities::Localization, nickname: 'showLocalization' }
        get ':id' do
          require_scope! :'view:localizations'
          authorize! :view, localization!

          present localization, with: ::V1::Entities::Localization
        end

        desc 'Delete localization', { nickname: 'deleteLocalization' }
        delete ':id' do
          require_scope! :'modify:localizations'
          authorize! :delete, localization!

          localization.destroy
        end

        desc 'Create a localization', { entity: ::V1::Entities::Localization, params: ::V1::Entities::Localization.documentation, nickname: 'createLocalization' }
        post do
          require_scope! :'modify:localizations'
          authorize! :create, ::Localization

          allowed_params = remove_params(::V1::Entities::Localization.documentation.keys, :id, :created_at, :updated_at, :available_locales, :creator)

          @localization = ::Localization.new(declared(params, {include_missing: false}, allowed_params))
          localization.user = current_user!
          localization.save!

          present localization, with: ::V1::Entities::Localization
        end

        desc 'Update a localization', { entity: ::V1::Entities::Localization, params: ::V1::Entities::Localization.documentation, nickname: 'updateLocalization' }
        put ':id' do
          require_scope! :'modify:localizations'
          authorize! :update, localization!

          allowed_params = remove_params(::V1::Entities::Localization.documentation.keys, :created_at, :updated_at, :available_locales, :creator)

          localization.update!(declared(params, {include_missing: false}, allowed_params))

          present localization, with: ::V1::Entities::Localization
        end
      end
    end
  end
end

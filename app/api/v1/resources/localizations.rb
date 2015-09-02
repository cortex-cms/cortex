require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Localizations < Grape::API
        helpers Helpers::SharedParams

        resource :localizations do
          helpers Helpers::PaginationHelper
          helpers Helpers::JargonHelper
          helpers Helpers::LocalizationHelper

          desc 'Show all localizations', { entity: Entities::Localization, nickname: 'showAllLocalizations' }
          params do
            use :pagination
          end
          oauth2 'view:localizations'
          get do
            authorize! :view, ::Localization

            @localizations = Kaminari.paginate_array(localization_service.all).page(page).per(per_page)

            set_pagination_headers(@localizations, 'localizations')
            present @localizations, with: Entities::Localization
          end

          desc 'Get localization', { entity: Entities::Localization, nickname: 'showLocalization' }
          oauth2 'view:localizations'
          get ':id' do
            authorize! :view, localization!

            @localization = localization_service.get

            present @localization, with: Entities::Localization
          end

          desc 'Delete localization', { nickname: 'deleteLocalization' }
          oauth2 'modify:localizations'
          delete ':id' do
            authorize! :delete, localization!

            @localization = localization_service.delete

            present @localization, with: Entities::Localization
          end

          desc 'Create a localization', { entity: Entities::Localization, params: Entities::Localization.documentation, nickname: 'createLocalization' }
          oauth2 'modify:localizations'
          post do
            authorize! :create, ::Localization

            allowed_params = remove_params(Entities::Localization.documentation.keys, :id, :created_at, :updated_at, :available_locales, :locales, :creator)

            @localization = localization_service.create(declared(params, {include_missing: false}, allowed_params))

            present @localization, with: Entities::Localization
          end

          desc 'Update a localization', { entity: Entities::Localization, params: Entities::Localization.documentation, nickname: 'updateLocalization' }
          oauth2 'modify:localizations'
          put ':id' do
            authorize! :update, localization!

            allowed_params = remove_params(Entities::Localization.documentation.keys, :created_at, :updated_at, :available_locales, :locales, :creator)

            @localization = localization_service.update(declared(params, {include_missing: false}, allowed_params))

            present @localization, with: Entities::Localization
          end
        end
      end
    end
  end
end

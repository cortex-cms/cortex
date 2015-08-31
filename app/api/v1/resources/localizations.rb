require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Localizations < Grape::API
        helpers Helpers::SharedParams
        doorkeeper_for :all, scopes: [:public]

        resource :localizations do
          helpers Helpers::PaginationHelper
          helpers Helpers::LocalizationHelper

          desc 'Show all localizations', { entity: Entities::Localization, nickname: 'showAllLocalizations' }
          params do
            use :pagination
          end
          get scopes: [:'view:localizations'] do
            authorize! :view, ::Localization

            @localizations = ::Localization.order(created_at: :desc).page(page).per(per_page)

            set_pagination_headers(@localizations, 'localizations')
            present @localizations, with: Entities::Localization
          end

          desc 'Get localization', { entity: Entities::Localization, nickname: 'showLocalization' }
          get ':id', scopes: [:'view:localizations'] do
            authorize! :view, localization!

            present localization, with: Entities::Localization
          end

          desc 'Delete localization', { nickname: 'deleteLocalization' }
          delete ':id', scopes: [:'modify:localizations'] do
            authorize! :delete, localization!

            localization.destroy
          end

          desc 'Create a localization', { entity: Entities::Localization, params: Entities::Localization.documentation, nickname: 'createLocalization' }
          post scopes: [:'modify:localizations'] do
            authorize! :create, ::Localization

            allowed_params = remove_params(Entities::Localization.documentation.keys, :id, :created_at, :updated_at, :available_locales, :creator)

            @localization = ::Localization.new(declared(params, {include_missing: false}, allowed_params))
            localization.user = current_user!
            localization.save!

            present localization, with: Entities::Localization
          end

          desc 'Update a localization', { entity: Entities::Localization, params: Entities::Localization.documentation, nickname: 'updateLocalization' }
          put ':id', scopes: [:'modify:localizations'] do
            authorize! :update, localization!

            allowed_params = remove_params(Entities::Localization.documentation.keys, :created_at, :updated_at, :available_locales, :creator)

            localization.update!(declared(params, {include_missing: false}, allowed_params))

            present localization, with: Entities::Localization
          end
        end
      end
    end
  end
end

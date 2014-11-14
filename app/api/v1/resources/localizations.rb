require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Localizations < Grape::API
        resource :localizations do
          helpers Helpers::JargonHelper
          helpers Helpers::LocalizationHelper

          desc 'Show all localizations', { entity: Entities::Localization, nickname: 'showAllLocalizations' }
          get do
            require_scope! :'view:localizations'
            authorize! :view, ::Localization

            @localizations = jargon.localizations.query

            status @localizations.status
            present @localizations, with: Entities::Localization
          end

          desc 'Get localization', { entity: Entities::Localization, nickname: 'showLocalization' }
          get ':id' do
            require_scope! :'view:localizations'
            authorize! :view, localization!

            @localization = jargon.localizations(params[:id]).get

            status @localization.status
            present @localization, with: Entities::Localization
          end

          desc 'Delete localization', { nickname: 'deleteLocalization' }
          delete ':id' do
            require_scope! :'modify:localizations'
            authorize! :delete, localization!

            @localization = jargon.localizations(params[:id]).delete

            status @localization.status
            present @localization, with: Entities::Localization
          end

          desc 'Create a localization', { entity: Entities::Localization, params: Entities::Localization.documentation, nickname: 'createLocalization' }
          post do
            require_scope! :'modify:localizations'
            authorize! :create, ::Localization

            allowed_params = remove_params(Entities::Localization.documentation.keys, :created_at, :updated_at, :available_locales, :locales)

            @localization = jargon.localizations.save(declared(params, {include_missing: false}, allowed_params))

            status @localization.status
            present @localization, with: Entities::Localization
          end

          desc 'Update a localization', { entity: Entities::Localization, params: Entities::Localization.documentation, nickname: 'updateLocalization' }
          put ':id' do
            require_scope! :'modify:localizations'
            authorize! :update, localization!

            allowed_params = remove_params(Entities::Localization.documentation.keys, :created_at, :updated_at, :available_locales, :locales)

            @localization = jargon.localizations.save(declared(params, {include_missing: false}, allowed_params))

            status @localization.status
            present @localization, with: Entities::Localization
          end
        end
      end
    end
  end
end

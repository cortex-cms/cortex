require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Locales < Grape::API
        resource :localizations do
          segment '/:localization_id' do
            resource :locales do
              helpers Helpers::JargonHelper
              helpers Helpers::LocaleHelper

              desc 'Show all locales', {entity: Entities::Locale, nickname: 'showAllLocales'}
              get do
                require_scope! :'view:locales'
                authorize! :view, ::Locale

                @locales = LocalizationService(params[:localization_id]).all

                status @locales.status
                present @locales, with: Entities::Locale
              end

              desc 'Get locale', {entity: Entities::Locale, nickname: 'showLocale'}
              get ':name' do
                require_scope! :'view:locales'
                authorize! :view, locale!

                @locale = LocalizationService(params[:localization_id]).get_locale(params[:name])

                status @locale.status
                present @locale, with: Entities::Locale
              end

              desc 'Delete locale', {nickname: 'deleteLocale'}
              delete ':name' do
                require_scope! :'modify:locales'
                authorize! :delete, locale!

                @locale = LocalizationService(params[:localization_id]).delete_locale(params[:name])

                status @locale.status
                present @locale, with: Entities::Locale
              end

              desc 'Create a locale', {entity: Entities::Locale, params: Entities::Locale.documentation, nickname: 'createLocale'}
              post do
                require_scope! :'modify:locales'
                authorize! :create, ::Locale

                allowed_params = remove_params(Entities::Locale.documentation.keys, :created_at, :updated_at, :available_locales, :locales)

                @locale = LocalizationService(params[:localization_id]).create_locale(declared(params, {include_missing: false}, allowed_params))

                status @locale.status
                present @locale, with: Entities::Locale
              end

              desc 'Update a locale', {entity: Entities::Locale, params: Entities::Locale.documentation, nickname: 'updateLocale'}
              put ':name' do
                require_scope! :'modify:locales'
                authorize! :update, locale!

                allowed_params = remove_params(Entities::Locale.documentation.keys, :created_at, :updated_at, :available_locales, :locales)

                @locale = LocalizationService(params[:localization_id]).update_locale(declared(params, {include_missing: false}, allowed_params))

                status @locale.status
                present @locale, with: Entities::Locale
              end
            end
          end
        end
      end
    end
  end
end

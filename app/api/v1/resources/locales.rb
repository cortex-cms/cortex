require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Locales < Grape::API
        helpers Helpers::SharedParams

        resource :localizations do
          segment '/:id' do
            resource :locales do
              include Grape::Kaminari
              helpers Helpers::LocaleHelper
              helpers Helpers::LocalizationHelper

              paginate per_page: 25

              desc 'Show all locales', {entity: Entities::Locale, nickname: 'showAllLocales'}
              get do
                require_scope! :'view:locales'
                authorize! :view, ::Locale

                @locales = localization.locales.order(created_at: :desc)

                Entities::Locale.represent paginate(@locales)
              end

              desc 'Get locale', {entity: Entities::Locale, nickname: 'showLocale'}
              get ':locale_name' do
                require_scope! :'view:locales'
                authorize! :view, locale!

                @locale = Locale.find_by_name!(params[:locale_name])

                present @locale, with: Entities::Locale
              end

              desc 'Delete locale', {nickname: 'deleteLocale'}
              delete ':locale_name' do
                require_scope! :'modify:locales'
                authorize! :delete, locale!

                locale.destroy!
              end

              desc 'Create a locale', {entity: Entities::Locale, params: Entities::Locale.documentation, nickname: 'createLocale'}
              post do
                require_scope! :'modify:locales'
                authorize! :create, ::Locale

                allowed_params = remove_params(Entities::Locale.documentation.keys, :id, :created_at, :updated_at, :available_locales, :locales, :creator)

                @locale = localization.locales.new(declared(params, {include_missing: false}, allowed_params))
                @locale.user = current_user!
                localization.save!

                present @locale, with: Entities::Locale
              end

              desc 'Update a locale', {entity: Entities::Locale, params: Entities::Locale.documentation, nickname: 'updateLocale'}
              put ':locale_name' do
                require_scope! :'modify:locales'
                authorize! :update, locale!

                allowed_params = remove_params(Entities::Locale.documentation.keys, :id, :created_at, :updated_at, :available_locales, :locales, :creator)

                locale.update!(declared(params, {include_missing: false}, allowed_params))

                present locale, with: Entities::Locale
              end
            end
          end
        end
      end
    end
  end
end

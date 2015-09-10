require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Webpages < Grape::API
        helpers Helpers::SharedParams

        doorkeeper_for :index, :feed, :show, scopes: [:'view:webpages']
        doorkeeper_for :create, :update, :destroy, scopes: [:'modify:webpages']

        resource :webpages do
          helpers Helpers::PaginationHelper
          helpers Helpers::WebpagesHelper

          desc 'Show all webpages', { entity: Entities::Webpage, nickname: 'showAllWebpages' }
          params do
            use :pagination
          end
          get do
            authorize! :view, ::Webpage

            @webpages = ::GetWebpages.call(params: declared(webpage_params, include_missing: false), page: page, per_page: per_page, tenant: current_tenant.id).webpages
            set_pagination_headers(@webpages, 'webpages')
            present @webpages, with: Entities::Webpage, full: true
          end

          desc 'Show Webpage Snippets as public feed by URL', { entity: Entities::Webpage, nickname: 'showWebpageFeed' }
          params do
            requires :url, type: String
          end
          get 'feed' do
            @webpage ||= Webpage.find_by_url(params[:url])
            not_found! unless @webpage
            authorize! :view, @webpage
            present @webpage, with: Entities::Webpage
          end

          desc 'Get webpage', { entity: Entities::Webpage, nickname: 'showWebpage' }
          get ':id' do
            authorize! :view, webpage!

            present webpage, with: Entities::Webpage, full: true
          end

          desc 'Create webpage', { entity: Entities::Webpage, params: Entities::Webpage.documentation, nickname: 'createWebpage' }
          post do
            authorize! :create, ::Webpage

            webpage_params = params[:webpage] || params

            @webpage = ::Webpage.new(declared(webpage_params, { include_missing: false }, Entities::Webpage.documentation.keys))
            webpage.user = current_user!
            webpage.save!

            present webpage, with: Entities::Webpage, full: true
          end

          desc 'Update webpage', { entity: Entities::Webpage, params: Entities::Webpage.documentation, nickname: 'updateWebpage' }
          put ':id' do
            authorize! :update, webpage!

            webpage_params = params[:webpage] || params
            allowed_params = remove_params(Entities::Webpage.documentation.keys, :user) + [:snippets_attributes]
            update_params = declared(webpage_params, { include_missing: false }, allowed_params)
            update_params[:snippets_attributes].each {|snippet|
              snippet.user = current_user!
              snippet[:document_attributes].user = current_user!
            }

            webpage.update!(update_params.to_hash)

            present webpage, with: Entities::Webpage, full: true
          end

          desc 'Delete webpage', { nickname: 'deleteWebpage' }
          delete ':id' do
            authorize! :delete, webpage!

            begin
              webpage.destroy
            rescue Cortex::Exceptions::ResourceConsumed => e
              error = error!({
                               error:   'Conflict',
                               message: e.message,
                               status:  409
                             }, 409)
              error
            end
          end
        end
      end
    end
  end
end

require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Applications < Grape::API
        helpers Helpers::SharedParams

        doorkeeper_for :index, :show, scopes: [:'view:applications']
        doorkeeper_for :create, :update, :destroy, scopes: [:'modify:applications']

        resource :applications do
          helpers Helpers::PaginationHelper
          helpers Helpers::ApplicationsHelper


          desc 'Show all applications', { entity: Entities::Application, nickname: 'showAllApplications' }
          params do
            use :pagination
          end
          get do
            authorize! :view, ::Application

            @applications = ::Application.where(tenant: current_tenant).page(page).per(per_page)

            set_pagination_headers(@applications, 'applications')
            present @applications, with: Entities::Application
          end

          desc 'Show an application', { entity: Entities::Application, nickname: "showApplication" }
          get ':id' do
            present application!, with: Entities::Application
          end

          desc 'Create an application', { entity: Entities::Application, params: Entities::Application.documentation, nickname: "createApplication" }
          params do
            requires :name, type: String, desc: "Application Name"
          end
          post do
            authorize! :create, Application

            allowed_params = remove_params(Entities::Application.documentation.keys, :children)

            @application = ::Application.new(declared(params, { include_missing: true }, allowed_params))
            application.tenant = current_tenant
            application.save!
            present application, with: Entities::Application
          end

          desc 'Update an application', { entity: Entities::Application, params: Entities::Application.documentation, nickname: "updateApplication" }
          put ':id' do
            authorize! :update, application!

            allowed_params = remove_params(Entities::Application.documentation.keys, :children)

            application.update!(declared(params, { include_missing: false }, allowed_params))
            present application, with: Entities::Application
          end

          desc 'Delete an application', { nickname: "deleteApplication" }
          delete ':id' do
            authorize! :delete, application!

            application.destroy
          end
        end

      end
    end
  end
end

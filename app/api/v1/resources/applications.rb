require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Applications < Grape::API
        helpers Helpers::SharedParams

        resource :applications do
          helpers Helpers::PaginationHelper
          helpers Helpers::ApplicationsHelper


          desc 'Show all applications', { entity: Entities::Application, nickname: 'showAllApplications' }
          params do
            use :pagination
          end
          get do
            require_scope! :'view:applications'
            authorize! :view, ::Application
          end

          desc 'Show an application', { entity: Entities::Application, nickname: "showApplication" }
          get ':id' do
            require_scope! :'view:applications'
            present application!, with: Entities::Application
          end

          desc 'Create an application', { entity: Entities::Application, params: Entities::Application.documentation, nickname: "createApplication" }
          params do
            requires :name, type: String, desc: "Application Name"
          end
          post do
            require_scope! :'modify:applications'
            authorize! :create, Application

            allowed_params = remove_params(Entities::Application.documentation.keys, :children)

            @application = ::Application.new(declared(params, { include_missing: true }, allowed_params))
            application.tenant = current_tenant
            application.save!
            present application, with: Entities::Application
          end

          desc 'Update an application', { entity: Entities::Application, params: Entities::Application.documentation, nickname: "updateApplication" }
          put ':id' do
            require_scope! :'modify:applications'
            authorize! :update, application!

            allowed_params = remove_params(Entities::Application.documentation.keys, :children)

            application.update!(declared(params, { include_missing: false }, allowed_params))
            present application, with: Entities::Application
          end

          desc 'Delete an application', { nickname: "deleteApplication" }
          delete ':id' do
            require_scope! :'modify:applications'
            authorize! :delete, application!

            application.destroy
          end
        end

      end
    end
  end
end

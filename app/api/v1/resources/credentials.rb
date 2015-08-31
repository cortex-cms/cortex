require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Credentials < Grape::API
        helpers Helpers::SharedParams
        doorkeeper_for :all, scopes: [:public]

        resource :applications do
          segment '/:id' do
            resource :credentials do
              helpers Helpers::PaginationHelper
              helpers Helpers::ApplicationsHelper

              desc 'Show all credentials', {entity: Entities::Credential, nickname: 'showAllCredentials'}
              get scopes: [:'view:application'] do
                authorize! :view, ::Application

                @credentials = application!.credentials.page(page).per(per_page)

                set_pagination_headers(@credentials, 'credentials')
                present @credentials, with: Entities::Credential
              end

              desc 'Get credential', {entity: Entities::Credential, nickname: 'showCredential'}
              get ':credential_id', scopes: [:'view:application'] do
                authorize! :view, application!

                @credential = application!.credentials.find(params[:credential_id])

                present @credential, with: Entities::Credential
              end

              desc 'Delete credential', {nickname: 'deleteCredential'}
              delete ':credential_id', scopes: [:'modify:application'] do
                authorize! :delete, application!

                @credential = application!.credentials.find(params[:credential_id]).delete

                present @credential, with: Entities::Credential
              end

              desc 'Create a credential', {entity: Entities::Credential, params: Entities::Credential.documentation, nickname: 'createCredential'}
              post scopes: [:'modify:application'] do
                authorize! :create, ::Application

                allowed_params = remove_params(Entities::Credential.documentation.keys, :id, :created_at, :updated_at)

                @credential = application!.credentials.new(declared(params, {include_missing: false}, allowed_params))
                @credential.save!

                present @credential, with: Entities::Credential
              end

              desc 'Update a credential', {entity: Entities::Credential, params: Entities::Credential.documentation, nickname: 'updateCredential'}
              put ':credential_id', scopes: [:'modify:application'] do
                authorize! :update, application!

                allowed_params = remove_params(Entities::Credential.documentation.keys, :id, :created_at, :updated_at)

                @credential = application!.credentials.find(params[:credential_id])
                @credential.update!(declared(params, {include_missing: false}, allowed_params))

                present @credential, with: Entities::Credential
              end
            end
          end
        end
      end
    end
  end
end

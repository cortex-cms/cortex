require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources

      class Tenants < Grape::API
        helpers Helpers::SharedParams

        doorkeeper_for :index, :hierarchy, :show, scopes: [:'view:tenants']
        doorkeeper_for :update, :create, :destroy, scopes: [:'modify:tenants']
        doorkeeper_for '/:version/tenants/:id/users', scopes: [:'view:users']

        resource :tenants do
          helpers Helpers::PaginationHelper
          helpers Helpers::TenantsHelper

          desc 'Show all tenants', { entity: Entities::Tenant, nickname: "showAllTenants" }
          params do
            use :pagination
          end
          get do
            authorize! :view, Tenant

            present Tenant.page(page).per(per_page), using: Entities::Tenant, children: params[:include_children]
          end

          desc 'Show tenant hierarchy', { entity: Entities::Tenant, nickname: "showTenantHierarchy" }
          params do
            use :pagination
          end
          get :hierarchy do
            authorize! :view, Tenant

            present Tenant.roots, using: Entities::Tenant, children: true
          end

          desc 'Show a tenant', { entity: Entities::Tenant, nickname: "showTenant" }
          get ':id' do
            present tenant!, with: Entities::Tenant, children: false
          end

          desc 'Create a tenant', { entity: Entities::Tenant, params: Entities::Tenant.documentation, nickname: "createTenant" }
          params do
            optional :name, type: String, desc: "Tenant Name"
          end
          post do
            authorize! :create, Tenant

            allowed_params = remove_params(Entities::Tenant.documentation.keys, :children)

            @tenant = ::Tenant.new(declared(params, { include_missing: true }, allowed_params))
            tenant.owner = current_user
            tenant.save!
            present tenant, with: Entities::Tenant
          end

          desc 'Update a tenant', { entity: Entities::Tenant, params: Entities::Tenant.documentation, nickname: "updateTenant" }
          put ':id' do
            authorize! :update, tenant!

            allowed_params = remove_params(Entities::Tenant.documentation.keys, :children)

            tenant.update!(declared(params, { include_missing: false }, allowed_params))
            present tenant, with: Entities::Tenant
          end

          desc 'Delete a tenant', { nickname: "deleteTenant" }
          delete ':id' do
            authorize! :delete, tenant!

            tenant.destroy
          end

          segment '/:id' do
            resource :users do

              desc 'Show all users belonging to a tenant', { entity: Entities::User, nickname: "showAllTenantUsers" }
              params do
                use :pagination
                use :search
              end

              get do
                authorize! :view, User

                @users = User.tenantUsers(params[:id]).page(page).per(per_page)
                set_pagination_headers(@users, 'users')
                present @users, with: Entities::User, full: true
              end
            end
          end
        end
      end
    end
  end
end

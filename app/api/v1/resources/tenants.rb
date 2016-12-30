module V1
  module Resources
    class Tenants < Grape::API
      helpers ::V1::Helpers::SharedParamsHelper
      helpers ::V1::Helpers::ParamsHelper

      resource :tenants do
        include Grape::Kaminari
        helpers ::V1::Helpers::TenantsHelper

        paginate per_page: 25

        desc 'Show all tenants', { entity: ::V1::Entities::Tenant, nickname: "showAllTenants" }
        get do
          require_scope! 'view:tenants'
          authorize! :view, Tenant

          ::V1::Entities::Tenant.represent paginate(Tenant.all), children: params[:include_children]
        end

        desc 'Show tenant hierarchy', { entity: ::V1::Entities::Tenant, nickname: "showTenantHierarchy" }
        get :hierarchy do
          require_scope! 'view:tenants'
          authorize! :view, Tenant

          present Tenant.roots, using: ::V1::Entities::Tenant, children: true
        end

        desc 'Show a tenant', { entity: ::V1::Entities::Tenant, nickname: "showTenant" }
        get ':id' do
          present tenant!, with: ::V1::Entities::Tenant, children: false
        end

        desc 'Create a tenant', { entity: ::V1::Entities::Tenant, params: ::V1::Entities::Tenant.documentation, nickname: "createTenant" }
        params do
          optional :name, type: String, desc: "Tenant Name"
        end
        post do
          require_scope! 'modify:tenants'
          authorize! :create, Tenant

          allowed_params = remove_params(::V1::Entities::Tenant.documentation.keys, :children)

          @tenant = ::Tenant.new(declared(params, { include_missing: true }, allowed_params))
          tenant.owner = current_user
          tenant.save!
          present tenant, with: ::V1::Entities::Tenant
        end

        desc 'Update a tenant', { entity: ::V1::Entities::Tenant, params: ::V1::Entities::Tenant.documentation, nickname: "updateTenant" }
        put ':id' do
          require_scope! 'modify:tenants'
          authorize! :update, tenant!

          allowed_params = remove_params(::V1::Entities::Tenant.documentation.keys, :children)

          tenant.update!(declared(params, { include_missing: false }, allowed_params))
          present tenant, with: ::V1::Entities::Tenant
        end

        desc 'Delete a tenant', { nickname: "deleteTenant" }
        delete ':id' do
          require_scope! 'modify:tenants'
          authorize! :delete, tenant!

          tenant.destroy
        end

        segment '/:id' do
          resource :users do
            include Grape::Kaminari
            helpers ::V1::Helpers::UsersHelper

            paginate per_page: 25

            desc 'Show all users belonging to a tenant', { entity: ::V1::Entities::User, nickname: "showAllTenantUsers" }
            params do
              use :search
            end
            get do
              authorize! :view, User
              require_scope! 'view:users'

              @users = ::GetUsers.call(params: declared(clean_params(params), include_missing: false), tenant_id: params[:id]).users
              set_paginate_headers(@users)
              ::V1::Entities::User.represent @users, full: true
            end
          end
        end
      end
    end
  end
end

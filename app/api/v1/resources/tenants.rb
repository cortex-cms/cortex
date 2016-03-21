require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Tenants < Grape::API
        helpers Helpers::SharedParamsHelper
        helpers Helpers::ParamsHelper

        resource :tenants do
          include Grape::Kaminari
          helpers Helpers::TenantsHelper

          paginate per_page: 25

          desc 'Show all tenants', { entity: Entities::Tenant, nickname: "showAllTenants" }
          get do
            require_scope! :'view:tenants'
            authorize! :view, Tenant

            Entities::Tenant.represent paginate(Tenant.all), children: params[:include_children]
          end

          desc 'Show tenant hierarchy', { entity: Entities::Tenant, nickname: "showTenantHierarchy" }
          get :hierarchy do
            require_scope! :'view:tenants'
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
            require_scope! :'modify:tenants'
            authorize! :create, Tenant

            allowed_params = remove_params(Entities::Tenant.documentation.keys, :children)

            @tenant = ::Tenant.new(declared(params, { include_missing: true }, allowed_params))
            tenant.owner = current_user
            tenant.save!
            present tenant, with: Entities::Tenant
          end

          desc 'Update a tenant', { entity: Entities::Tenant, params: Entities::Tenant.documentation, nickname: "updateTenant" }
          put ':id' do
            require_scope! :'modify:tenants'
            authorize! :update, tenant!

            allowed_params = remove_params(Entities::Tenant.documentation.keys, :children)

            tenant.update!(declared(params, { include_missing: false }, allowed_params))
            present tenant, with: Entities::Tenant
          end

          desc 'Delete a tenant', { nickname: "deleteTenant" }
          delete ':id' do
            require_scope! :'modify:tenants'
            authorize! :delete, tenant!

            tenant.destroy
          end

          segment '/:id' do
            resource :users do
              include Grape::Kaminari
              helpers Helpers::UsersHelper

              paginate per_page: 25

              desc 'Show all users belonging to a tenant', { entity: Entities::User, nickname: "showAllTenantUsers" }
              params do
                use :search
              end
              get do
                authorize! :view, User
                require_scope! :'view:users'

                @users = ::GetUsers.call(params: declared(clean_params(params), include_missing: false), tenant_id: params[:id]).users
                Entities::User.represent set_paginate_headers(@users), full: true
              end
            end
          end
        end
      end
    end
  end
end

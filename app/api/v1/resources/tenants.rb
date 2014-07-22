require_relative '../helpers/resource_helper'

module API::V1
  module Resources

    class Tenants < Grape::API
      helpers Helpers::SharedParams

      resource :tenants do
        helpers Helpers::PaginationHelper
        helpers Helpers::TenantsHelper

        desc 'Show all tenants', { entity: Entities::Tenant }
        params do
          use :pagination
        end
        get do
          require_scope! :'view:tenants'
          authorize! :view, Tenant

          present Tenant.page(page).per(per_page), using: Entities::Tenant, children: params[:include_children]
        end

        desc 'Show tenant hierarchy'
        params do
          use :pagination
        end
        get :hierarchy do
          require_scope! :'view:tenants'
          authorize! :view, Tenant

          present Tenant.roots, using: Entities::Tenant, children: true
        end

        desc 'Show a tenant', { entity: Entities::Tenant }
        get ':id' do
          present tenant!, with: Entities::Tenant, children: false
        end

        desc 'Create a tenant', { entity: Entities::Tenant, params: Entities::Tenant.documentation }
        params do
          requires :name, type: String, desc: "Tenant Name"
        end
        post do
          require_scope! :'modify:tenants'
          authorize! :create, Tenant

          allowed_params = remove_params(Entities::Tenant.documentation.keys, :children)

          @tenant = ::Tenant.new(declared(params, { include_missing: true }, allowed_params))
          tenant.user = current_user
          tenant.save!
          present tenant, with: Entities::Tenant
        end

        desc 'Update a tenant', { entity: Entities::Tenant, params: Entities::Tenant.documentation }
        put ':id' do
          require_scope! :'modify:tenants'
          authorize! :update, tenant!

          allowed_params = remove_params(Entities::Tenant.documentation.keys, :children)

          tenant.update!(declared(params, { include_missing: false }, allowed_params))
          present tenant, with: Entities::Tenant
        end

        desc 'Delete a tenant'
        delete ':id' do
          require_scope! :'modify:tenants'
          authorize! :delete, tenant!

          tenant.destroy
        end
      end
    end
  end
end

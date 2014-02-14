require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    module TenantParams
      extend Grape::API::Helpers

      params :tenant_params do
        optional :name
        optional :parent_id
        optional :contact_name
        optional :contact_email
        optional :contact_phone
        optional :active_at
        optional :deactive_at
        optional :contract
        optional :did
        optional :subdomain
      end
    end

    class Tenants < Grape::API
      helpers TenantParams
      helpers Helpers::SharedParams

      resource :tenants do
        helpers Helpers::PaginationHelper
        helpers Helpers::TenantsHelper

        desc 'Show all tenants'
        params do
          use :pagination
        end
        get do
          present Tenant.page(page).per(per_page),
                  with: params[:include_children] ? Entities::TenantWithChildren : Entities::Tenant
        end

        desc 'Show tenant hierarchy'
        params do
          use :pagination
        end
        get :hierarchy do
          present Tenant.roots, with: Entities::TenantWithChildren
        end

        desc 'Show a tenant'
        get ':id' do
          present tenant!, with: params[:include_children] ? Entities::TenantWithChildren : Entities::Tenant
        end

        desc 'Create a tenant'
        params do
          use :tenant_params
        end
        post do
          @tenant = ::Tenant.new(declared(params))
          tenant.user = current_user
          tenant.save!
          present tenant, with: Entities::Tenant
        end

        desc 'Update a tenant'
        params do
          use :tenant_params
        end
        put ':id' do
          tenant!.update!(declared(params, include_missing: false))
          present tenant, with: Entities::Tenant
        end

        desc 'Delete a tenant'
        delete ':id' do
          tenant!.destroy
        end
      end
    end
  end
end

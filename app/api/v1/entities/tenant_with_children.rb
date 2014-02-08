require_relative 'tenant'

module API::V1
  module Entities
    class TenantWithChildren < Tenant
      expose :children, with: TenantWithChildren
    end
  end
end

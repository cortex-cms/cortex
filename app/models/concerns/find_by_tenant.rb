module FindByTenant
  extend ActiveSupport::Concern

  included do
    scope :find_by_tenant_id, ->(tenant_id) { joins(user: :tenant).where(users: { :'tenant_id' => tenant_id})}
  end
end

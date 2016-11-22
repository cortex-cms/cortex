module FindByTenant
  extend ActiveSupport::Concern

  included do
    scope :find_by_tenant_id, ->(tenant_id) { joins(user: :tenant).where(users: { :'tenant_id' => tenant_id })}
    scope :find_by_user_tenant, ->(user) { joins(user: :tenant).where(users: { :'tenant_id' => user.tenant.id })}
  end
end

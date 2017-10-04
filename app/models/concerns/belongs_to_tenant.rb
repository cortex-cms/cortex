module BelongsToTenant
  extend ActiveSupport::Concern

  included do
    belongs_to :tenant

    validates :tenant, presence: true

    scope :find_by_tenant, ->(tenant) { where(tenant_id: tenant.id) }
  end
end

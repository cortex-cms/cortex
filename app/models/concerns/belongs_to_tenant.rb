module BelongsToTenant
  extend ActiveSupport::Concern

  included do
    belongs_to :tenant
    validates :tenant, presence: true
  end
end

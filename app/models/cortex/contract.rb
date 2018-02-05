# TODO: Refactor
module Cortex
  class Contract < Cortex::ApplicationRecord
    include Cortex::BelongsToTenant

    validates :name, presence: true

    has_many :content_types
    has_many :contentable_decorators, as: :contentable
    has_many :decorators, through: :contentable_decorators
  end
end

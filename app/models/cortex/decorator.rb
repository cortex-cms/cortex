module Cortex
  class Decorator < Cortex::ApplicationRecord
    include Cortex::BelongsToTenant

    has_many :contentable_decorators

    validates :name, :data, presence: true
  end
end

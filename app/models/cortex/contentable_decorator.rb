module Cortex
  class ContentableDecorator < Cortex::ApplicationRecord
    include Cortex::BelongsToTenant

    belongs_to :decorator
    belongs_to :contentable, polymorphic: true
  end
end

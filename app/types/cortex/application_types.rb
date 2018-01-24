require 'dry-types'

module Cortex
  module ApplicationTypes
    User = Dry::Types::Definition.new(::Cortex::User)
    ContentType = Dry::Types::Definition.new(::Cortex::ContentType)
    ContentItem = Dry::Types::Definition.new(::Cortex::ContentItem)
    FieldType = Dry::Types::Definition.new(::Cortex::FieldType)
    FieldItem = Dry::Types::Definition.new(::Cortex::UpdateFieldItemTransaction)
    Field = Dry::Types::Definition.new(::Cortex::Field)
  end
end

module Cortex
  module ApplicationTypes
    User = Dry::Types::Definition.new(::Cortex::User)
    Users = CoreTypes::Strict::Array.of(ApplicationTypes::User)

    ContentType = Dry::Types::Definition.new(::Cortex::ContentType)
    ContentTypes = CoreTypes::Strict::Array.of(ApplicationTypes::ContentType)

    ContentItem = Dry::Types::Definition.new(::Cortex::ContentItem)
    ContentItems = CoreTypes::Strict::Array.of(ApplicationTypes::ContentItem)

    FieldType = Dry::Types::Definition.new(::Cortex::FieldType)
    FieldTypes = CoreTypes::Strict::Array.of(ApplicationTypes::FieldType)

    FieldItem = Dry::Types::Definition.new(::Cortex::UpdateFieldItemTransaction)
    FieldItems = CoreTypes::Strict::Array.of(ApplicationTypes::FieldItem)

    Field = Dry::Types::Definition.new(::Cortex::Field)
    Fields = CoreTypes::Strict::Array.of(ApplicationTypes::Field)
  end
end

module Cortex
  module ApplicationTypes
    User = Dry::Types::Definition.new(::Cortex::User)
    Users = CoreTypes::Strict::Array.member(ApplicationTypes::User)

    ContentType = Dry::Types::Definition.new(::Cortex::ContentType)
    ContentTypes = CoreTypes::Strict::Array.member(ApplicationTypes::ContentType)

    ContentItem = Dry::Types::Definition.new(::Cortex::ContentItem)
    ContentItems = CoreTypes::Strict::Array.member(ApplicationTypes::ContentItem)

    FieldType = Dry::Types::Definition.new(::Cortex::FieldType)
    FieldTypes = CoreTypes::Strict::Array.member(ApplicationTypes::FieldType)

    FieldItem = Dry::Types::Definition.new(::Cortex::UpdateFieldItemTransaction)
    FieldItems = CoreTypes::Strict::Array.member(ApplicationTypes::FieldItem)

    Field = Dry::Types::Definition.new(::Cortex::Field)
    Fields = CoreTypes::Strict::Array.member(ApplicationTypes::Field)
  end
end

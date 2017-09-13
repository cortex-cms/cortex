require 'dry-types'

module ApplicationTypes
  User = Dry::Types::Definition.new(::User)
  ContentType = Dry::Types::Definition.new(::ContentType)
  ContentItem = Dry::Types::Definition.new(::ContentItem)
  FieldType = Dry::Types::Definition.new(::FieldType)
  FieldItem = Dry::Types::Definition.new(::UpdateFieldItemTransaction)
  Field = Dry::Types::Definition.new(::Field)
end

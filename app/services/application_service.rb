require 'dry-struct'

class ApplicationService < Dry::Struct
  constructor_type :schema

  attr_reader :errors
end

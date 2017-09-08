require 'dry-struct'

class ApplicationService < Dry::Struct
  attr_reader :errors
end

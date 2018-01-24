require 'dry-struct'

module Cortex
  class ApplicationService < Dry::Struct
    constructor_type :schema

    attr_reader :errors
  end
end

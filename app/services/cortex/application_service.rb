require 'dry-struct'

module Cortex
  class ApplicationService < Dry::Struct
    attr_reader :errors
  end
end

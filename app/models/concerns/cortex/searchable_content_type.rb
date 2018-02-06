module Cortex
  module SearchableContentType
    extend ActiveSupport::Concern

    included do
      include Cortex::Searchable

      # TODO: ContentType mappings
    end
  end
end

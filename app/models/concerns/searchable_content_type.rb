module SearchableContentType
  extend ActiveSupport::Concern

  included do
    include Searchable

    # TODO: ContentType mappings
  end
end

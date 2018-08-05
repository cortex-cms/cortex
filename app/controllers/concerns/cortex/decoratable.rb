# TODO: ContentTypes, Decorators or Contracts themselves should inform the system what the correct Decorator is, not a hardcoded concern method
module Cortex
  module Decoratable
    extend ActiveSupport::Concern

    included do
      def index_decorator(content_type)
        content_type.decorators.find_by_name('Index')
      end

      def wizard_decorator(content_type)
        content_type.decorators.find_by_name('Wizard')
      end
    end
  end
end

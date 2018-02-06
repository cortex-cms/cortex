module Cortex
  class ContentTypeCell < Cortex::ApplicationCell
    property :name
    property :icon

    def nav
      render
    end
  end
end

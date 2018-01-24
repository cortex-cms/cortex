module Cortex
  class ApplicationCell < Cell::ViewModel
    include ReactOnRailsHelper
    include Cortex::Engine.routes.url_helpers

    self.view_paths = ["#{Cortex::Engine.root}/app/cells"]
  end
end

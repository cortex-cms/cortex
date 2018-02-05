CortexStarter::Application.routes.draw do
  mount Cortex::Engine => "/"

  # Override routes with additional application-specific needs here
end

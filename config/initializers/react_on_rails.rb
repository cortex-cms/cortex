ActiveSupport.on_load(:action_view) do
  include ReactOnRailsHelper
end

module RenderingExtension
  def self.custom_context(_view_context)
    {
      environment: Rails.env
    }
  end
end

ReactOnRails.configure do |config|
  config.rendering_extension = RenderingExtension
end

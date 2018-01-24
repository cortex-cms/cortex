module Cortex
  def self.plugins
    @plugins ||= Cortex::Plugins.constants.map(&Cortex::Plugins.method(:const_get))
  end

  def self.plugin_library_names
    @plugin_library_names ||= @plugins.map do |plugin|
      plugin.to_s.parameterize
    end
  end

  def self.plugin_paths
    @plugin_paths ||= @plugins.map do |plugin|
      plugin::Engine.root
    end
  end
end

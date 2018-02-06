module CortexStarter
  def self.config
    @config ||= Hashr.new(Rails.application.config_for(:config))
  end

  def self.apollo_engine_proxy_config
    @apollo_engine_proxy_config ||= Rails.application.config_for(:apollo_engine_proxy)
  end
end

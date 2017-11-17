module Cortex
  def self.config
    @config ||= Hashr.new(Rails.application.config_for(:config))
  end

  def self.apollo_engine_proxy_config
    @apollo_engine_proxy_config ||= Rails.application.config_for(:apollo_engine_proxy)
  end
end

::SeedData = Hashr.new(YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env])

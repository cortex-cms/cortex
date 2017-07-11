module Cortex
  def self.config
    @config ||= Hashr.new(Rails.application.config_for(:config))
  end
end

::SeedData = Hashr.new(YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env])

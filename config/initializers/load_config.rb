module Cortex
  def self.config
    @config ||= load_config
  end

  private

  def self.load_config
    c = Hashr.new(Rails.application.config_for(:config))
    c.media.allowed_media_types = Hashr.new(Rails.application.config_for(:media_types)).allowed
    c
  end
end

::SeedData = Hashr.new(YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env])

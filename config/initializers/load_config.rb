module Cortex
  def self.config
    @config ||= load_config
  end

  private

  def self.load_config
    c = Hashr.new(YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env])
    c.media.allowed_media_types = Hashr.new(YAML.load_file("#{Rails.root}/config/media_types.yml")).allowed
    c.sanitize_whitelist = Hashr.new(YAML.load_file("#{Rails.root}/config/sanitize_whitelist.yml"))
    c
  end
end

::SeedData = Hashr.new(YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env])

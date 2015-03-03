module Cortex
  def self.config
    @config ||= load_config
  end

  private

  def self.load_config
    c = Hashr.new(self.load_yaml("#{Rails.root}/config/config.yml")[Rails.env])
    c.media.allowed_media_types = Hashr.new(self.load_yaml("#{Rails.root}/config/media_types.yml")).allowed
    c
  end

  def self.load_yaml(file)
    # interpolate file with ERB to allow templating (<%= ENV['...'] %>)
    YAML.load(ERB.new(File.new(file).read).result)
  end
end

::SeedData = Hashr.new(YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env])

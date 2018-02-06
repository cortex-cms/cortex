module Cortex
  def self.config
    @config ||= self.load_yaml("#{Cortex::Engine.root}/config/config.yml")
  end

  def self.seed_data
    @seed_data ||= self.load_yaml("#{Cortex::Engine.root}/db/seeds.yml")
  end

  private

  def self.load_yaml(file)
    # interpolate file with ERB to allow templating (<%= ENV['...'] %>)
    YAML.load(ERB.new(File.new(file).read).result)[Rails.env].deep_symbolize_keys
  end
end

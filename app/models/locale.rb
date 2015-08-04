class Locale < ActiveRecord::Base
  require 'yaml'

  belongs_to :user
  belongs_to :localization

  validates_uniqueness_of :name, scope: :localization_id
  validates_presence_of :name

  def yaml
    data.to_yaml
  end

  def yaml= p
    self.data = YAML.load(p)
  end

  def json
    data.to_json
  end

  def json= p
    self.data = JSON.parse(p)
  end
end

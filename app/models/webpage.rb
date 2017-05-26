class Webpage < ApplicationRecord
  include FindByTenant
  include SearchableWebpage

  serialize :tables_widget
  serialize :charts_widget

  scope :find_by_protocol_agnostic_url, ->(suffix) { where('url LIKE :suffix', suffix: "%#{suffix}") }

  acts_as_paranoid
  acts_as_taggable_on :seo_keywords

  belongs_to :user
  has_many :snippets, inverse_of: :webpage
  has_many :documents, through: :snippets, :dependent => :destroy

  accepts_nested_attributes_for :snippets

  def tables_widget_yaml
    tables_widget.to_yaml
  end

  def tables_widget_yaml= p
    self.tables_widget = YAML.load(p)
  end

  def tables_widget_json
    tables_widget.to_json
  end

  def tables_widget_json= p
    self.tables_widget = JSON.parse(p, quirks_mode: true) # Quirks mode will let us parse a null JSON object
  end

  def charts_widget_yaml
    charts_widget.to_yaml
  end

  def charts_widget_yaml= p
    self.charts_widget = YAML.load(p)
  end

  def charts_widget_json
    charts_widget.to_json
  end

  def charts_widget_json= p
    self.charts_widget = JSON.parse(p, quirks_mode: true) # Quirks mode will let us parse a null JSON object
  end

  def accordion_group_widget_yaml
    accordion_group_widget.to_yaml
  end

  def accordion_group_widget_yaml= p
    self.accordion_group_widget = YAML.load(p)
  end

  def accordion_group_widget_json
    accordion_group_widget.to_json
  end

  def accordion_group_widget_json= p
    self.accordion_group_widget = JSON.parse(p, quirks_mode: true) # Quirks mode will let us parse a null JSON object
  end
end

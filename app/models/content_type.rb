require 'elasticsearch/model/indexing'

class ContentType < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_paranoid
  validates :name, :creator, presence: true
  validates :name, uniqueness: true
  after_save :rebuild_content_items_index

  belongs_to :creator, class_name: "User"
  belongs_to :contract

  has_many :fields
  has_many :content_items, -> { order(created_at: :desc) }
  has_many :contentable_decorators, as: :contentable
  has_many :decorators, through: :contentable_decorators

  accepts_nested_attributes_for :fields

  # TODO: Extract to a module
  def self.permissions
    Permission.select { |perm| perm.resource_type = self }
  end

  def content_items_index_name
    content_type_name_sanitized = name.parameterize('_')
    "#{Rails.env}_content_type_#{content_type_name_sanitized}_content_items"
  end

  def wizard_decorator
    decorators.find_by_name("Wizard")
  end

  def index_decorator
    decorators.find_by_name("Index")
  end

  def rss_decorator
    decorators.find_by_name("Rss")
  end

  def content_items_mappings
    mappings = Elasticsearch::Model::Indexing::Mappings.new(content_items_index_name, {})

    fields.each do |field|
      mappings.indexes field.mapping[:name], field_mappings(field)
    end

    mappings
  end

  def content_items_settings
    {}
  end

  def rebuild_content_items_index
    create_content_items_index({force: true})
  end

  def create_content_items_index(options={})
    client = __elasticsearch__.client
    client.indices.delete index: content_items_index_name rescue nil if options[:force]

    client.indices.create index: content_items_index_name,
                          body: {
                            settings: content_items_settings.to_hash,
                            mappings: content_items_mappings.to_hash}
  end

  private

  def field_mappings(field)
    mappings = {type: field.mapping[:type]}
    mappings[:analyzer] = field.mapping[:analyzer] if field.mapping[:analyzer]
    mappings
  end

end

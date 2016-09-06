require 'elasticsearch/model/indexing'

class ContentType < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_paranoid
  validates :name, :creator, :contract_id, presence: true
  after_save :rebuild_content_items_index

  belongs_to :creator, class_name: "User"
  belongs_to :contract

  has_many :fields, -> { order(order: :asc) }
  has_many :content_items
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

  def content_items_mappings
    mappings = Elasticsearch::Model::Indexing::Mappings.new(content_items_index_name, {})

    fields.each do |field|
      mappings.indexes field.mapping[:name], :type => field.mapping[:type], :analyzer => field.mapping[:analyzer]
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
end

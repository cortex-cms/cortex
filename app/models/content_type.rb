require 'elasticsearch/model/indexing'

class ContentType < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_paranoid
  validates :name, :creator, presence: true
  after_save :rebuild_items_index

  belongs_to :creator, class_name: "User"
  has_many :fields, -> { order(order: :asc) }
  has_many :content_items

  accepts_nested_attributes_for :fields

  def items_index_name
    "content_item_#{name.underscore}_items"
  end

  def items_mappings
    mappings = Elasticsearch::Model::Indexing::Mappings.new(items_index_name, {})

    fields.each do |field|
      field.field_type_instance.mappings.each do |mapping|
        mappings.indexes mapping
      end
    end

    mappings
  end

  def items_settings
    {}
  end

  def rebuild_items_index
    create_items_index({force: true})
  end

  def create_items_index(options={})
    client = __elasticsearch__.client
    client.indices.delete index: items_index_name rescue nil if options[:force]

    client.indices.create index: items_index_name,
                          body: {
                            settings: items_settings.to_hash,
                            mappings: items_mappings.to_hash }
  end
end

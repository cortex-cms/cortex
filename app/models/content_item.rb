class ContentItem < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_paranoid

  belongs_to :creator, class_name: "User"
  belongs_to :author, class_name: "User"
  belongs_to :content_type
  has_many :field_items, -> { joins(:field).order("fields.order ASC") }, dependent: :destroy

  accepts_nested_attributes_for :field_items

  validates :creator_id, :author_id, :content_type_id, presence: true

  after_update :update_indexes

  def as_indexed_json(options = {})
    json = as_json(only: [:id, :name])

    field_items.each do |field_item|
      json.merge!(field_item.field.field_type_instance(field_name: field_item.field.name).as_indexed_json(field_item.data))
    end
    
    json
  end

  def update_indexes
    __elasticsearch__.client.index(
      { index: content_type.items_index_name,
        type: content_type.items_index_name,
        id: id,
        body: as_indexed_json }
    )
  end
end

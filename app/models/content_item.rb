class ContentItem < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_paranoid

  belongs_to :creator, class_name: "User"
  belongs_to :author, class_name: "User"
  belongs_to :updated_by, class_name: "User"
  belongs_to :content_type
  has_many :field_items, -> { joins(:field).order("fields.order ASC") }, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :field_items

  validates :creator_id, :author_id, :content_type_id, presence: true

  after_save :index

  def as_indexed_json(options = {})
    json = as_json
    # json[:tenant_id] = TODO

    field_items.each do |field_item|
      field_type = field_item.field.field_type_instance(field_name: field_item.field.name)
      json.merge!(field_type.field_item_as_indexed_json_for_field_type(field_item))
    end

    json
  end

  def index
    __elasticsearch__.client.index(
      {index: content_type.content_items_index_name,
       type: self.class.name.underscore,
       id: id,
       body: as_indexed_json}
    )
  end
end

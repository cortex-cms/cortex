class ContentItem < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_paranoid

  belongs_to :creator, class_name: "User"
  belongs_to :updated_by, class_name: "User"
  belongs_to :content_type
  has_many :field_items, -> { joins(:field).order("fields.order ASC") }, dependent: :destroy

  accepts_nested_attributes_for :field_items

  validates :creator_id, :content_type_id, presence: true

  after_save :index
  after_save :update_tag_lists

  def self.taggable_fields
    taggable_on_array = Field.select { |f| f.field_type == "tag_field_type" }.map { |f| f.name.downcase.gsub(" ", "_") }
  end

  acts_as_taggable_on taggable_fields

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

  def update_tag_lists
    field_items.select { |fi| fi.field.field_type == "tag_field_type" }.map { |fi| [fi.field.name, fi.data["tag_list"] ] }.each { |tags| self.send("#{tags[0].downcase.gsub(' ', '_').singularize}_list=", tags[1]) }
  end
end

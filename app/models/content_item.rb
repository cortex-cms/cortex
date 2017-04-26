class ContentItem < ApplicationRecord
  include ActiveModel::Transitions
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  state_machine do
    state :draft
  end

  acts_as_paranoid

  belongs_to :creator, class_name: "User"
  belongs_to :updated_by, class_name: "User"
  belongs_to :content_type
  has_many :field_items, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :field_items

  default_scope { order(created_at: :desc) }

  validates :creator_id, :content_type_id, presence: true

  after_save :index
  after_save :update_tag_lists

  def self.taggable_fields
    Field.select { |field| field.field_type_instance.is_a?(TagFieldType) }.map { |field_item| field_item.name.parameterize('_') }
  end

  def author_email
    creator.email
  end

  def publish_state
    PublishStateService.new.content_item_state(self)
  end

  def rss_url(base_url, slug_field_id)
    slug = field_items.find_by_field_id(slug_field_id).data.values.join
    "#{base_url}#{slug}"
  end

  def rss_date(date_field_id)
    date = field_items.find_by_field_id(date_field_id).data["timestamp"]
    Date.parse(date).rfc2822
  end

  def rss_author(field_id)
    author = field_items.find_by_field_id(field_id).data["author_name"]
    "editorial@careerbuilder.com (#{author})"
  end

  # The Method self.taggable_fields must always be above the acts_as_taggable_on inclusion for it.
  # Due to lack of hoisting - it cannot access the method unless the method appears before it in this
  # file.

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
       type: self.class.name.parameterize('_'),
       id: id,
       body: as_indexed_json}
    )
  end

  def tag_field_items
    field_items.select { |field_item| field_item.field.field_type_instance.is_a?(TagFieldType) }
  end

  def tree_list(field_id)
    tree_array = Field.find(field_id).metadata["allowed_values"]["data"]["tree_array"]
    tree_values = field_items.find { |field_item| field_item.field_id == field_id }.data["values"]

    tree_values.map { |value| tree_array.find { |node| node["id"] == value.to_i }["node"]["name"] }.join(",")
  end

  def update_tag_lists
    tag_data = tag_field_items.map { |field_item| {tag_name: field_item.field.name, tag_list: field_item.data["tag_list"]} }

    tag_data.each do |tags|
      ContentItemService.update_tags(self, tags)
    end
  end

  # Metaprograms a number of convenience methods for content_items
  def method_missing(*args)
    if args[0].to_s.include?("?")
      # Used to check state - allows for methods such as #published? and #expired?
      # Will return true if the active_state corresponds to the name of the method
      "#{publish_state.downcase}?" == args[0].to_s
    else
      # Used to query for any field on the relevant ContentType and return data from the content_item
      field_items.select { |field_item| field_item.field.name.parameterize({ separator: '_' }) == args[0].to_s }.first.data.values[0]
    end
  end
end

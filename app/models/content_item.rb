class ContentItem < ActiveRecord::Base
  include ActiveModel::Transitions
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  state_machine :initial => :default do
    state :draft
    state :scheduled, :enter => lambda { |content_item| content_item.schedule_publish }
    state :published
    state :default #the default state that is given to an object - this should only ever exist on ContentItems where the ContentType is not publishable

    event :publish do
      transitions :to => :published, :from => [:default, :draft, :scheduled]
    end

    event :schedule do
      transitions :to => :scheduled, :from => [:default, :draft]
    end

    event :draft do
      transitions :to => :draft, :from => [:default, :published, :scheduled]
    end
  end

  acts_as_paranoid

  belongs_to :creator, class_name: "User"
  belongs_to :updated_by, class_name: "User"
  belongs_to :content_type
  has_many :field_items, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :field_items

  validates :creator_id, :content_type_id, presence: true

  after_save :index
  after_save :update_tag_lists

  def self.taggable_fields
    Field.select { |field| field.field_type_instance.is_a?(TagFieldType) }.map { |field_item| field_item.name.parameterize('_') }
  end

  # The following method (#author_image) is currently faked
  # author_image is faked pending being able to reference the specific User object (ex:
  # content_item.author.user_image)

  def author_image
    "<img src='#{creator.gravatar}' height='50px' />".html_safe
  end

  def publish_state
    state.titleize
  end

  def schedule_publish
    timestamp = field_items.find { |field_item| field_item.field.name == "Publish Date" }.data["timestamp"]
    PublishContentItemJob.set(wait_until: DateTime.parse(timestamp)).perform_later(self)
  end

  def link_base_url
    "https://robohash.org/#{id}.png"
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

  def update_tag_lists
    tag_data = tag_field_items.map { |field_item| {tag_name: field_item.field.name, tag_list: field_item.data["tag_list"]} }

    tag_data.each do |tags|
      ContentItemService.update_tags(self, tags)
    end
  end
end

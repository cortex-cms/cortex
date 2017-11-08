class ContentItem < ApplicationRecord
  include ActiveModel::Transitions

  include Searchable
  include BelongsToTenant

  scope :last_updated_at, -> { order(updated_at: :desc).select('updated_at').first.updated_at }

  belongs_to :creator, class_name: 'User'
  belongs_to :updated_by, class_name: 'User', optional: true
  belongs_to :content_type
  has_many :field_items, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :field_items

  default_scope { order(created_at: :desc) }

  validates :creator, :content_type, presence: true

  state_machine do
    state :draft
    state :scheduled

    event :schedule do
      transitions :to => :scheduled, :from => [:draft]
    end

    event :draft do
      transitions :to => :draft, :from => [:scheduled]
    end
  end

  def publish_state
    PublishStateService.new.content_item_state(self)
  end

  def rss_url(base_url, slug_field_id) # TODO: abstract RSS to separate app once API is implemented
    slug = field_items.find_by_field_id(slug_field_id).data.values.join
    "#{base_url}#{slug}"
  end

  def rss_date(date_field_id) # TODO: abstract RSS to separate app once API is implemented
    date = field_items.find_by_field_id(date_field_id).data["timestamp"]
    Date.parse(date).rfc2822
  end

  def rss_author(field_id) # TODO: abstract RSS to separate app once API is implemented
    author = field_items.find_by_field_id(field_id).data["author_name"]
    "editorial@careerbuilder.com (#{author})"
  end

  def as_indexed_json(options = {})
    json = as_json
    # json[:tenant_id] = TODO

    field_items.each do |field_item|
      field_type = field_item.field.field_type_instance(field_name: field_item.field.name)
      json.merge!(field_type.field_item_as_indexed_json_for_field_type(field_item))
    end

    json
  end

  # FieldItem and State Convenience Methods. TODO: move to concern? transactions?
  def method_missing(method_name, *arguments, &block)
    super unless dynamic_method?(method_name)

    if dynamic_state_check?(method_name)
      # Used to check state - allows for methods such as #published? and #expired?
      # Will return true if the active_state corresponds to the name of the method
      "#{publish_state.downcase}?" == method_name.to_s
    else
      # Used to query for any field on the relevant ContentType and return data from the content_item
      field_items.find { |field_item| field_item.field.name.parameterize(separator: '_') == method_name.to_s }.data.values.first
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    dynamic_method?(method_name) || super
  end

  private

  def dynamic_method?(method_name)
    dynamic_state_check?(method_name) || has_field_item?(method_name)
  end

  def dynamic_state_check?(method_name)
    method_name.to_s.include? '?'
  end

  # TODO: this logic effectively gets called multiple times (slow?) - how do we optimize or cache the result?
  def has_field_item?(method_name)
    field_items.any? { |field_item| field_item.field.name.parameterize(separator: '_') == method_name.to_s }
  end
end

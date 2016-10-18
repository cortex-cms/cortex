class ContentItemService < CortexService
  include WidgetParsersHelper

  attribute :id, String
  attribute :content_item_params, Object
  attribute :current_user, User
  attribute :creator, User
  attribute :field_items, Array[FieldItem]
  attribute :state, String

  def create
    transact_and_refresh do
      @content_item = ContentItem.new
      content_item_params["field_items_attributes"].to_hash.each do |key, value|
        value.delete("id")
        @content_item.field_items << FieldItem.new(value)
      end

      content_item_params.delete("field_items_attributes")
      @content_item.attributes = content_item_params.to_hash
    end
  end

  def update
    @content_item = ContentItem.find(id)

    transact_and_refresh do
      @content_item.update(content_item_attributes)
    end
  end

  # This method will set the tag list (whatever it may be named) to the array of tag_data
  def self.update_tags(content_item, tag_data)
    # First we get the name of the list, as determined by the field with '=' at the end
    # ex: seo_keyword_list=
    tag_list_name = "#{tag_data[:tag_name].singularize.parameterize('_')}_list="
    tag_array = tag_data[:tag_list]

    # We then execute the tag_list_name= as a method using #send, which sets it to the tag_array values
    content_item.send(tag_list_name, tag_array)
  end

  private

  def transact_and_refresh
    ActiveRecord::Base.transaction do
      yield
      parse_field_items!
      @content_item.save!
      execute_state_change(@content_item)
      update_search!
    end
  end

  def parse_field_items!
    @content_item.field_items.each do |field_item|
      if field_item.field.metadata && field_item.field.metadata['parse_widgets']
        parse_widgets!(field_item)
      end
    end
  end

  def update_search!
    # TODO: implement ES index updates
    true
  end

  def content_item_attributes
    attributes = content_item_params || {creator: creator, content_type: content_type, field_items: field_items}
    attributes.merge! latest_history_patch
  end

  def latest_history_patch
    history_patch = {}
    history_patch.merge! last_updated_by
  end

  def last_updated_by
    {updated_by: current_user}
  end

  def execute_state_change(content_item)
    if content_item.can_transition?(state)
      state_method = "#{state}!"
      content_item.send(state_method)
    end
  end
end

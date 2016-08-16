class ContentItemService < CortexService
  attribute :id, Integer
  attribute :content_item_params, Object
  attribute :current_user, User
  attribute :creator, User
  attribute :field_items, Array[FieldItem]

  def create
    transact_and_refresh do
      @content_item = ContentItem.new
      content_item_params["content_item"]["field_items_attributes"].to_hash.each do |key, value|
        value.delete("id")
        @content_item.field_items << FieldItem.new(value)
      end
      content_item_params["content_item"].delete("field_items_attributes")
      @content_item.attributes = content_item_params["content_item"].to_hash
      @content_item.save
    end
  end

  def update
    @content_item = content_items.find_by_id(id)

    transact_and_refresh do
      @content_item.update(content_item_attributes)
    end
  end

  private

  def transact_and_refresh
    ActiveRecord::Base.transaction do
      yield
      update_search
    end
  end

  def update_search
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
end

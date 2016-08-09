class ContentItemService < CortexService
  attribute :id, Integer
  attribute :content_item_params, Object
  attribute :current_user, User
  attribute :creator, User
  attribute :field_items, Array[FieldItem]

  def create
    transact_and_refresh do
      @content_item = ContentItem.create!(content_item_attributes)
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
      update_history
    end
  end

  def update_history
    update_last_updated_by
  end

  def update_last_updated_by
    @content_item.update!(updated_by: current_user)
  end

  def content_item_attributes
    content_item_params || {creator: creator, content_type: content_type, field_items: field_items}
  end
end

class ContentItemService < ApplicationService
  include WidgetParsersHelper

  FieldItems = CoreTypes::Strict::Array.member(ApplicationTypes::FieldItem)

  attribute :id, CoreTypes::Strict::String.optional
  attribute :content_item_params, Object
  attribute :current_user, ApplicationTypes::User
  attribute :creator, ApplicationTypes::User.optional
  attribute :field_items, FieldItems
  attribute :state, CoreTypes::Strict::String
  class_attribute :form_fields

  def create
    transact_and_refresh do
      @content_item = ContentItem.new
      self.form_fields = field_items_attributes.to_h.values.each_with_object({}) do |param, hash_object|
        hash_object[param['field_id']] = param['data']
      end
      content_item_params['field_items_attributes'].to_hash.each do |key, field_item_attributes|
        field_item_attributes.delete('id')
        @content_item.field_items << NewFieldItemTransaction.new.call(field_item_attributes).value
      end

      content_item_params.delete('field_items_attributes')
      @content_item.attributes = content_item_params.to_hash
      @content_item.tenant = current_user.active_tenant # TODO: In future, grab from form/route, rather than current_user + perform authorization checks
    end
  end

  def update
    transact_and_refresh do
      @content_item = ContentItem.find(id)
      content_item_params['field_items_attributes'].to_hash.each do |key, field_item_attributes|
        @content_item.field_items << UpdateFieldItemTransaction.new.call(field_item_attributes).value
      end

      content_item_params.delete('field_items_attributes')
      @content_item.assign_attributes(content_item_attributes)
    end
  end

  private

  def transact_and_refresh
    ActiveRecord::Base.transaction do
      yield
      parse_field_items!
      @content_item.save!
      execute_state_change(@content_item)
    end
  end

  def parse_field_items!
    @content_item.field_items.each do |field_item|
      if field_item.field.metadata && field_item.field.metadata['parse_widgets']
        parse_widgets!(field_item)
      end
    end
  end

  def field_items_attributes
    content_item_params["field_items_attributes"]
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
    if state && content_item.can_transition?(state)
      state_method = "#{state}!"
      content_item.send(state_method)
    end
  end
end

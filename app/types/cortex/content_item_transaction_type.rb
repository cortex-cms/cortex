module Cortex
  class ContentItemTransactionType < TransactionType
    attribute :id, CoreTypes::Strict::String.optional
    attribute :content_type, ApplicationTypes::ContentType
    attribute :content_item_params, CoreTypes::Coercible::Hash.optional
    attribute :current_user, ApplicationTypes::User
    attribute :creator, ApplicationTypes::User.optional
    attribute :field_items, ApplicationTypes::FieldItems.optional
    attribute :state, CoreTypes::Strict::String.optional
  end
end

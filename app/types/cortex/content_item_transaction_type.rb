module Cortex
  class ContentItemTransactionType < TransactionType
    attribute :id, CoreTypes::Strict::String.optional.meta(omittable: true)
    attribute :content_type, ApplicationTypes::ContentType
    attribute :content_item, ApplicationTypes::ContentItem.optional.meta(omittable: true)
    attribute :content_item_params, CoreTypes::Coercible::Hash.optional.meta(omittable: true)
    attribute :current_user, ApplicationTypes::User
    attribute :state, CoreTypes::Strict::String.optional.meta(omittable: true)
  end
end

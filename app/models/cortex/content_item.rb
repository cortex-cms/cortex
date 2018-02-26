module Cortex
  class ContentItem < Cortex::ApplicationRecord
    include ActiveModel::Transitions

    include Cortex::SearchableContentItem
    include Cortex::BelongsToTenant

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
      # TODO: move logic to Transaction
      PublishStateService.new.content_item_state(self)
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
end

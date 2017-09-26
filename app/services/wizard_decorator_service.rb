class WizardDecoratorService < ApplicationService
  attribute :content_item, ApplicationTypes::ContentItem

  def data
    @content_item.content_type.wizard_decorator.data.deep_symbolize_keys
  end
end

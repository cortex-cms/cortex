class WizardDecoratorService < CortexService
  attribute :content_item, ContentItem

  def data
    @content_item.content_type.wizard_decorator.data
  end
end

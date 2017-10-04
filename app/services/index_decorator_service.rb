class IndexDecoratorService < ApplicationService
  attribute :content_type, ApplicationTypes::ContentType

  def data
    @content_type.index_decorator.data.deep_symbolize_keys
  end
end

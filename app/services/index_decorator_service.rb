class IndexDecoratorService < CortexService
  attribute :content_type, ContentType

  def data
    @content_type.index_decorator.data.deep_symbolize_keys
  end
end

class GetMultipleMedia
  include Interactor

  SEARCH_PARAMS = %w(q).freeze

  def call
    media = ::Media

    if has_search_params?
      media = media.search_with_params(context.params, context.tenant)
    else
      media = media.show_all(context.tenant)
    end

    context.media = media
  end

  private

  def has_search_params?
    (context.params.to_h.keys & SEARCH_PARAMS).any?
  end
end

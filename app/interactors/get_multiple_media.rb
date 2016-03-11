class GetMultipleMedia
  include Interactor

  SEARCH_PARAMS = %w{q}

  def call
    media = ::Media

    if has_search_params?
      media = media.search_with_params(context.params, context.tenant)
    else
      media = media.show_all(context.tenant)
    end

    media = media.page(context.params.page).per(context.params.per_page)
    context.media = media.records
  end

  private

  def has_search_params?
    Array(context.params.keys & SEARCH_PARAMS).length > 0
  end
end

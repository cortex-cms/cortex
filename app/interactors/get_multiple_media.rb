class GetMultipleMedia
  include Interactor

  SEARCH_PARAMS = %i{q}

  def call
    media = ::Media
    media = media.search_with_params(context.params).records if has_search_params?
    media = media.find_by_tenant_id(context.tenant) if context.tenant
    media = media.page(context.page).per(context.per_page).order(created_at: :desc)
    context.media = media
  end

  private

  def has_search_params?
    Array(context.params.keys & SEARCH_PARAMS).length > 0
  end
end

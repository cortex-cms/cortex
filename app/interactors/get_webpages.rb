class GetWebpages
  include Interactor

  SEARCH_PARAMS = %w{q}

  def call
    webpages = ::Webpage
    webpages = webpages.search_with_params(context.params).records if has_search_params?
    webpages = webpages.find_by_tenant_id(context.tenant) if context.tenant
    webpages = webpages.page(context.page).per(context.per_page).order(created_at: :desc)
    context.webpages = webpages
  end

  private

  def has_search_params?
    Array(context.params.keys & SEARCH_PARAMS).length > 0
  end
end

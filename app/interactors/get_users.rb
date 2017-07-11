class GetUsers
  include Interactor

  SEARCH_PARAMS = %w{q}

  def call
    users = ::User

    if has_search_params?
      users = users.search_with_params(context.params, context.tenant_id)
    else
      users = users.show_all(context.tenant_id)
    end

    context.users = users
  end

  private

  def has_search_params?
    Array(context.params.keys & SEARCH_PARAMS).length > 0
  end
end

class GetContentItems
  include Interactor

  def call
    content_items = ContentType.find_by_name(context.params.content_type_name).content_items.order(created_at: :desc)
    context.content_items = content_items.page(context.params.page).per(context.params.per_page)
  end
end

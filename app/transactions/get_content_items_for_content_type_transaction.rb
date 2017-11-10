class GetContentItemsForContentTypeTransaction < ApplicationTransaction
  step :search

  def search(params)
    tenant_id = params[:args][:tenant_id] || params[:active_tenant].id

    tenant_filter = { term: { tenant_id: tenant_id } }
    content_type_filter = { term: { content_type_id: params[:content_type].id } }
    bool = { bool: { filter: [tenant_filter, content_type_filter] } }

    results = ContentItem.search({ query: bool, sort: [{ created_at: { order: 'desc' } }] }, index: params[:content_type].content_items_index_name)
    # TODO: basic pagination
    Right(results.records)
  end
end

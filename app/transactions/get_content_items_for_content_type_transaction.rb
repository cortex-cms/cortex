class GetContentItemsForContentTypeTransaction < ApplicationTransaction
  include Elasticsearch::DSL

  step :search

  def search(params)
    tenant_id = params[:args][:tenant_id] || params[:active_tenant].id
    content_type_id = params[:content_type].id

    definition = Elasticsearch::DSL::Search.search {
      query do
        bool do
          filter do
            term tenant_id: tenant_id
          end
          filter do
            term content_type_id: content_type_id
          end
        end
      end
      sort created_at: {
        order: 'desc'
      }
    }

    results = ContentItem.search(definition, index: params[:content_type].content_items_index_name)
    # TODO: basic pagination
    Right(results.records)
  end
end

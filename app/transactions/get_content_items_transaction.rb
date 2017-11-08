class GetContentItemsTransaction < ApplicationTransaction
  step :search

  def search(params)
    filter = {  }
    bool = { bool: { filter: [filter] } }

    results = ContentItem.search query: bool, sort: [{ created_at: { order: 'desc' } }]
    Right(results.records)
  end
end

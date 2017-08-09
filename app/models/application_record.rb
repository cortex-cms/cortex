class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # A bug in ES-Rails 5.x is breaking document updates:
  # https://github.com/elastic/elasticsearch-rails/issues/669
  after_commit :refresh_elasticsearch_index, on: :update, if: defined? __elasticsearch__

  private

  def refresh_elasticsearch_index
    __elasticsearch__.index_document refresh: true
  end
end

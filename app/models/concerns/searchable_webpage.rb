module SearchableWebpage
  extend ActiveSupport::Concern

  included do
    include Searchable

    mapping do
      indexes :name, :analyzer => :snowball
      indexes :url, :analyzer => :keyword
      indexes :created_by, :analyzer => :keyword
      indexes :created_at, :type => :date, :include_in_all => false
      indexes :deleted_at, :type => :date, :include_in_all => false
      indexes :updated_at, :type => :date, :include_in_all => false

      indexes :id, :type => :integer, :index => :not_analyzed
      indexes :tenant_id, :type => :integer, :index => :not_analyzed
      indexes :user_id, :type => :integer, :index => :not_analyzed
      indexes :thumbnail_file_name, :type => :string, :index => :not_analyzed
      indexes :thumbnail_content_type, :type => :string, :index => :not_analyzed
      indexes :thumbnail_file_size, :type => :long, :index => :not_analyzed
      indexes :thumbnail_updated_at, :type => :date, :index => :not_analyzed
      indexes :seo_title, :type => :string, :index => :not_analyzed
      indexes :seo_description, :type => :string, :index => :not_analyzed
      indexes :noindex, :type => :boolean, :index => :not_analyzed
      indexes :nofollow, :type => :boolean, :index => :not_analyzed
      indexes :nosnippet, :type => :boolean, :index => :not_analyzed
      indexes :noodp, :type => :boolean, :index => :not_analyzed
      indexes :noarchive, :type => :boolean, :index => :not_analyzed
      indexes :noimageindex, :type => :boolean, :index => :not_analyzed
      indexes :tables_widget, :type => :nested, :enabled => false
      indexes :accordion_group_widget, :type => :nested, :enabled => false
      indexes :card_group_widget, :type => :nested, :enabled => false
      indexes :charts_widget, :type => :nested, :enabled => false
      indexes :buy_box_widget, :type => :nested, :enabled => false
      indexes :carousels_widget, :type => :nested, :enabled => false
      indexes :galleries_widget, :type => :nested, :enabled => false
      indexes :slider_widget, :type => :nested, :enabled => false
      indexes :form_configs, :type => :nested, :enabled => false
      indexes :product_data, :type => :nested, :enabled => false
      indexes :product_information_widget, :type => :nested, :enabled => false
    end

    def as_indexed_json(options = {})
      json = as_json(options)
      json[:created_by] = user.fullname
      json[:tenant_id]  = user.tenant.id
      json
    end
  end

  module ClassMethods
    def search_with_params(params, tenant)
      query = { multi_match: { fields: %w(name^2 _all), query: query_massage(params[:q]) } }
      filter = { term: { tenant_id: tenant.id } }
      bool = { bool: { must: [query], filter: [filter] } }

      search query: bool
    end

    def show_all(tenant)
      filter = { term: { tenant_id: tenant.id } }
      bool = { bool: { filter: [filter] } }

      search query: bool, sort: [{ created_at: { order: 'desc' } }]
    end
  end
end

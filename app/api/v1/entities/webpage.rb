module V1
  module Entities
    class Webpage < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: 'Webpage ID', required: true }
      expose :name, documentation: { type: 'String', desc: 'Webpage Name', required: true }
      expose :created_at, documentation: { type: 'dateTime', desc: 'Created Date'}
      expose :updated_at, documentation: { type: 'dateTime', desc: 'Updated Date'}
      expose :snippets, with: '::V1::Entities::Snippet', documentation: {type: 'Snippet', is_array: true, desc: 'All associated Snippets for this Webpage'}

      expose :seo_title, documentation: { type: 'String', desc: "SEO Meta Tag Title" }
      expose :seo_description, documentation: { type: 'String', desc: "SEO Meta Tag Description" }
      expose :seo_keyword_list, documentation: {type: "String", is_array: true, desc: "SEO-specific keywords"}
      expose :noindex, documentation: { type: 'Boolean', desc: "SEO No Index Robots Setting" }
      expose :nofollow, documentation: { type: 'Boolean', desc: "SEO No Follow Robots Setting" }
      expose :noodp, documentation: { type: 'Boolean', desc: "SEO No ODP Setting" }
      expose :nosnippet, documentation: { type: 'Boolean', desc: "SEO No Snippet Robots Setting" }
      expose :noarchive, documentation: { type: 'Boolean', desc: "SEO No Archive Setting" }
      expose :noimageindex, documentation: { type: 'Boolean', desc: "SEO No Image Index Robots Setting" }

      expose :product_data_json, documentation:  {type: 'Hash', is_array: true, desc: 'Product Data as JSON'}

      expose :carousels_widget_json, documentation:  {type: 'Hash', is_array: true, desc: 'Carousels Widget Data as JSON'}
      expose :galleries_widget_json, documentation:  {type: 'Hash', is_array: true, desc: 'Galleries Widget Data as JSON'}
      expose :tables_widget_json, documentation:  {type: 'Hash', is_array: true, desc: 'Tables Widget Data as JSON'}
      expose :charts_widget_json, documentation:  {type: 'Hash', is_array: true, desc: 'Charts Widget Data as JSON'}
      expose :buy_box_widget_json, documentation:  {type: 'Hash', is_array: true, desc: 'Buy Box Widget Data as JSON'}
      expose :accordion_group_widget_json, documentation:  {type: 'Hash', is_array: true, desc: 'Accordion Group Widget Data as JSON'}

      with_options if: { full: true } do
        expose :user, with: '::V1::Entities::User', documentation: {type: 'User', desc: 'Owner'}
        expose :url, documentation: { type: 'String', desc: 'URL of Webpage' }

        expose :product_data_yaml, documentation:  {type: 'Hash', is_array: true, desc: 'Product Data as YAML'}

        expose :carousels_widget_yaml, documentation:  {type: 'Hash', is_array: true, desc: 'Carousels Widget Data as YAML'}
        expose :galleries_widget_yaml, documentation:  {type: 'Hash', is_array: true, desc: 'Galleries Widget Data as YAML'}
        expose :tables_widget_yaml, documentation:  {type: 'Hash', is_array: true, desc: 'Tables Widget Data as YAML'}
        expose :accordion_group_widget_yaml, documentation:  {type: 'Hash', is_array: true, desc: 'Accordion Group Widget Data as YAML'}
        expose :charts_widget_yaml, documentation:  {type: 'Hash', is_array: true, desc: 'Charts Widget Data as YAML'}
        expose :buy_box_widget_yaml, documentation:  {type: 'Hash', is_array: true, desc: 'Buy Box Widget Data as YAML'}
      end
    end
  end
end

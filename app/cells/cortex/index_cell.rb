module Cortex
  class IndexCell < Cortex::ApplicationCell
    property :data

    def index
      render
    end

    def table_headers
      render
    end

    def table_body
      render
    end

    private

    def render_table_header(column_data)
      column_data[:name]
    end

    def asset_field_item(content_item)
      # TODO: This needs to be generic functionality
      content_item.field_items.find { |field_item| field_item.field.name == 'Asset' }
    end

    def content_item_title(content_item)
      # TODO: This needs to be generic functionality
      content_item.field_items.find { |field_item| field_item.field.name == 'Title' }.data['text']
    end

    def content_item_thumb_url(content_item)
      # TODO: The thumb version needs to be configurable, and this needs to be in a plugin
      asset_field_item(content_item).data['asset']&.[]('versions')&.[]('mini')&.[]('url')
    end

    def content_item_asset_url(content_item)
      # TODO: This needs to be in a plugin
      asset_field_item(content_item).data['asset']['versions']['original']['url']
    end

    def content_item_asset_type(content_item)
      # TODO: This needs to be in a plugin
      MimeMagic.new(asset_field_item(content_item).data['asset']['versions']['original']['mime_type']).mediatype
    end

    def content_item_asset_alt_text(content_item)
      # TODO: This needs to be in a plugin
      content_item.field_items.find { |field_item| field_item.field.name == 'Alt Tag' }.data['text']
    end
  end
end

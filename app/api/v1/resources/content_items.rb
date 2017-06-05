module V1
  module Resources
    class ContentItems < Grape::API
      helpers ::V1::Helpers::SharedParamsHelper
      helpers ::V1::Helpers::ParamsHelper

      resource :content_items do
        include Grape::Kaminari
        paginate per_page: 25

        desc "Create a content item", { entity: ::V1::Entities::ContentItem, params: ::V1::Entities::ContentItem.documentation, nickname: "createContentItem" }
        params do
          requires :content_type_id, type: Integer, desc: "content type of content item"
        end
        post do
          require_scope! 'modify:content_items'
          authorize! :create, ::ContentItem
          @content_item = ::ContentItem.new(params.merge(author_id: current_user.id, creator_id: current_user.id))

          if @content_item.save
            present @content_item, with: ::V1::Entities::ContentItem, full: true
          else
            status 400
            { error: @content_item.errors.full_messages.join("\n") }
          end
        end

        desc 'Show all content items', { entity: ::V1::Entities::ContentItem, nickname: "showAllContentItems" }
        get do
          require_scope! 'view:content_items'
          authorize! :view, ::ContentItem
          @content_items = ::ContentItem.all

          present @content_items, with: ::V1::Entities::ContentItem, field_items: true
        end

        desc 'Show published content items', { entity: ::V1::Entities::ContentItem, nickname: "contentItemsFeed" }
        params do
          use :pagination
          requires :content_type_name, type: String, desc: "content type of content item"
        end
        get :feed do
          require_scope! 'view:content_items'
          authorize! :view, ::ContentItem

          last_updated_at = ContentItem.last_updated_at
          params_hash = Digest::MD5.hexdigest(declared(params).to_s)
          cache_key = "feed-#{last_updated_at}-#{current_tenant.id}-#{params_hash}"

          content_items = ::GetContentItems.call(params: declared(clean_params(params), include_missing: false), tenant: current_tenant, published: true).content_items
          set_paginate_headers(content_items)
          ::V1::Entities::ContentItem.represent content_items.to_a, field_items: true
        end

        desc 'Show a published content item', { entity: ::V1::Entities::ContentItem, nickname: "showFeedContentItem" }
        get 'feed/*id' do
          @content_item = ::GetContentItem.call(id: params[:id], published: true, tenant: current_tenant.id).content_item
          not_found! unless @content_item
          authorize! :view, @content_item
          present @content_item, with: ::V1::Entities::ContentItem, field_items: true
        end
      end
    end
  end
end

require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    class Posts < Grape::API
      helpers Helpers::SharedParams
      helpers Helpers::PostsHelper

      resource :posts do
        helpers Helpers::PaginationHelper

        desc 'Show all posts', { entity: Entities::Post, nickname: "showAllPosts" }
        params do
          use :pagination
          use :search
          use :post_metadata
        end
        get do
          require_scope! :'view:posts'
          authorize! :view, ::Post

          q = params[:q]
          if q.to_s != ''
            @posts = ::Post.search_with_params(params).page(page).per(per_page).records
          else
            @posts = ::Post.order(created_at: :desc).page(page).per(per_page)
          end

          set_pagination_headers(@posts, 'posts')
          present @posts, with: Entities::Post
        end

        desc 'Show published posts', { entity: Entities::PostBasic, nickname: "postFeed" }
        params do
          use :pagination
          use :search
          use :post_metadata
        end
        get 'feed' do
          @posts = ::Post.search_with_params(params, true).page(page).per(per_page).records
          set_pagination_headers(@posts, 'posts')
          present @posts, with: Entities::PostBasic
        end

        desc 'Show post tags'
        params do
          optional :s
        end
        get 'tags' do
          require_scope! :'view:posts'
          authorize! :view, Post

          tags = params[:s] \
            ? ::Post.tag_counts_on(:tags).where('name ILIKE ?', "%#{params[:s]}%") \
            : ::Post.tag_counts_on(:tags)

          if params[:popular]
            tags = tags.order('count DESC').limit(20)
          end

          present tags, with: Entities::Tag
        end

        desc 'Show all filters/facets for posts'
        params do
          optional :depth, default: 1, desc: "Minimum depth of filters"
        end
        get 'filters' do
          present :industries, ::Onet::Occupation.industries, with: Entities::Occupation
          present :categories, ::Category.where('depth >= ?', params[:depth]), with: Entities::Category
        end

        desc 'Show a post', { entity: Entities::Post, nickname: "showPost" }
        get ':id' do
          require_scope! :'view:posts'
          authorize! :view, post!

          present post, with: Entities::Post
        end

        desc 'Show related published posts', { entity: Entities::PostBasic, nickname: "relatedPosts" }
        get 'feed/:id/related' do
          @posts = published_post!.related(true).page(page).per(per_page).records
          set_pagination_headers(@posts, 'posts')
          present @posts, with: Entities::PostBasic
        end

        desc 'Create a post', { entity: Entities::Post, params: Entities::Post.documentation, nickname: "createAPost" }
        params do
          optional :featured_media_id
          optional :tile_media_id
        end
        post do
          require_scope! :'modify:posts'
          authorize! :create, Post

          @post = ::Post.new(declared(params, {include_missing: false}, Entities::Post.documentation.keys))
          post.user = current_user
          post.save!
          present post, with: Entities::Post
        end

        desc 'Update a post', { entity: Entities::Post, params: Entities::Post.documentation, nickname: "updateAPost" }
        put ':id' do
          require_scope! :'modify:posts'
          authorize! :update, post!

          allowed_params = remove_params(Entities::Post.documentation.keys, :featured_media, :tile_media, :media)

          if params[:type]
            post.update!({type: params[:type]}) if params[:type]
            reload_post
          end
          post.update!(declared(params, {include_missing: false}, allowed_params))

          if params[:tag_list]
            post.tag_list = params[:tag_list]
            post.save!
          end

          present post, with: Entities::Post
        end

        desc 'Delete a post', { nickname: "deleteAPost" }
        delete ':id' do
          require_scope! :'modify:posts'
          authorize! :delete, post!

          post.destroy
        end
      end
    end
  end
end

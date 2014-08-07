require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Posts < Grape::API
        helpers Helpers::SharedParams
        helpers Helpers::PostsHelper
        include Grape::Rails::Cache

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
            intersect = Array(params.keys & %w{q categories industries type job_phase})
            key_name = "posts:list:"
            intersect.each do |k|
              key_name += "#{k}=#{params[k]}"
            end
            if intersect.length == 0
              @posts = ::Post.page(page).per(per_page)
            else
              @posts = ::Post.search_with_params(declared(params, include_missing: false), false).page(page).per(per_page).records
            end

            set_pagination_headers(@posts, 'posts')
            present @posts, with: Entities::Post
          end

          desc 'Show published posts', { entity: Entities::Post, nickname: "postFeed" }
          params do
            use :pagination
            use :search
            use :post_metadata
          end
          get 'feed' do
            intersect = Array(params.keys & %w{q categories industries type job_phase page per_page})
            key_name = "posts:feed:list:"
            intersect.each do |k|
              key_name += "#{k}=#{params[k]}"
            end
            if intersect.length == 0
              @posts = ::Post.published.page(page).per(per_page)
            else
              @posts = ::Post.search_with_params(declared(params, include_missing: false), true).page(page).per(per_page).records
            end
            set_pagination_headers(@posts, 'posts')
            cache(key: key_name, etag: Post.order("updated_at desc").take(1), expires_in: 2.hours) do
                present @posts, with: Entities::Post, sanitize: true
            end
          end

          desc 'Show published post authors'
          get 'feed/authors' do
            present Author.published.distinct, with: Entities::Author
          end

          desc 'Show a published post', { entity: Entities::Post, nickname: "showFeedPost" }
          get 'feed/:id' do
            cache(key: "posts:feed:id:#{params[:id]}", etag: post.updated_at, expires_in: 2.hours) do
              present published_post, with: Entities::Post, sanitize: true, full: true
            end
          end

          desc 'Show related published posts', { entity: Entities::Post, nickname: "relatedPosts" }
          get 'feed/:id/related' do
            @posts = published_post!.related(true).page(page).per(per_page).records
            set_pagination_headers(@posts, 'posts')
            present @posts, with: Entities::Post
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

          desc 'Show all filters/facets for posts', { nickname: "showFilters" }
          params do
            optional :depth, default: 1, desc: "Minimum depth of filters"
          end
          get 'filters' do
            present :industries, ::Onet::Occupation.industries, with: Entities::Occupation
            present :categories, ::Category.where('depth >= ?', params[:depth]), with: Entities::Category
            present :job_phases, ::Category.roots, with: Entities::Category, children: true
          end

          desc 'Show a post', { entity: Entities::Post, nickname: "showPost" }
          get ':id' do
            require_scope! :'view:posts'
            authorize! :view, post!
            cache(key: "posts:id:#{params[:id]}", etag: post.updated_at, expires_in: 2.hours) do
              present post, with: Entities::Post, full: true
            end
          end

          desc 'Create a post', { entity: Entities::Post, params: Entities::Post.documentation, nickname: "createPost" }
          params do
            use :post_associations
          end
          post do
            require_scope! :'modify:posts'
            authorize! :create, Post

            allowed_params = remove_params(Entities::Post.documentation.keys, :featured_media, :tile_media, :media, :industries, :categories)

            @post = ::Post.new(declared(params, {include_missing: false}, allowed_params))
            post.user = params[:user] ? User.find(params[:user]) : current_user
            post.save!
            present post, with: Entities::Post, full: true
          end

          desc 'Update a post', { entity: Entities::Post, params: Entities::Post.documentation, nickname: "updatePost" }
          params do
            use :post_associations
          end
          put ':id' do
            require_scope! :'modify:posts'
            authorize! :update, post!

            allowed_params = remove_params(Entities::Post.documentation.keys, :featured_media, :tile_media, :media, :industries, :categories) + [:category_ids, :industry_ids, :author_id]

            if params[:type]
              post.update!({type: params[:type]}) if params[:type]
              reload_post
            end
            post.update!(declared(params, {include_missing: false}, allowed_params))

            if params[:tag_list]
              post.tag_list = params[:tag_list]
              post.save!
            end

            present post, with: Entities::Post, full: true
          end

          desc 'Delete a post', { nickname: "deletePost" }
          delete ':id' do
            require_scope! :'modify:posts'
            authorize! :delete, post!

            post.destroy
          end
        end
      end
    end
  end
end

require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Posts < Grape::API
        helpers Helpers::SharedParams
        helpers Helpers::PostsHelper

        resource :posts do
          include Grape::Kaminari
          paginate per_page: 25

          desc 'Show all posts', { entity: Entities::Post, nickname: "showAllPosts" }
          params do
            use :search
            use :post_metadata
          end
          get do
            require_scope! :'view:posts'
            authorize! :view, ::Post
            @posts = ::GetPosts.call(params: declared(post_params, include_missing: false), tenant: current_tenant.id).posts

            Entities::Post.represent paginate(@posts)
          end

          desc 'Show published posts', { entity: Entities::Post, nickname: "postFeed" }
          params do
            use :search
            use :post_metadata
          end
          get 'feed' do
            require_scope! :'view:posts'
            authorize! :view, ::Post
            last_updated_at = Post.last_updated_at
            params_hash     = Digest::MD5.hexdigest(declared(params).to_s)
            tenant          = current_tenant.id
            cache_key       = "feed-#{last_updated_at}-#{tenant}-#{params_hash}"

            posts_page = ::Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
              posts = ::GetPosts.call(params: declared(post_params, include_missing: false), tenant: tenant, published: true).posts
              Entities::Post.represent paginate(posts)
            end

            posts_page
          end

          desc 'Show published post authors'
          get 'feed/authors' do
            present Author.published.distinct, with: Entities::Author
          end

          desc 'Show a published post', { entity: Entities::Post, nickname: "showFeedPost" }
          get 'feed/:id' do
            @post = ::GetPost.call(id: params[:id], published: true, tenant: current_tenant.id).post
            not_found! unless @post
            authorize! :view, @post
            present @post, with: Entities::Post, full: true
          end

          desc 'Show related published posts', { entity: Entities::Post, nickname: "relatedPosts" }
          get 'feed/:id/related' do
            require_scope! :'view:posts'
            post = GetPost.call(id: params[:id], published: true).post
            not_found! unless post
            authorize! :view, post

            per_page = params[:per_page] || 5 # Ignore PaginationHelper's/Kaminari's per_page default - too large for related content!
            @posts = post.related(true)
            Entities::Post.represent paginate(@posts, per_page: 5)
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
            require_scope! :'view:posts'
            authorize! :view, Post
            present :industries, ::Onet::Occupation.industries, with: Entities::Occupation
            present :categories, ::Category.where('depth >= ?', params[:depth]), with: Entities::Category
            present :job_phases, ::Category.roots, with: Entities::Category, children: true
          end

          desc 'Show a post', { entity: Entities::Post, nickname: "showPost" }
          get ':id' do
            require_scope! :'view:posts'
            @post = ::GetPost.call(id: params[:id], tenant: current_tenant.id).post
            not_found! unless @post
            authorize! :view, @post
            present @post, with: Entities::Post, full: true
          end

          desc 'Create a post', { entity: Entities::Post, params: Entities::Post.documentation, nickname: "createPost" }
          params do
            use :post_associations
          end
          post do
            require_scope! :'modify:posts'
            authorize! :create, Post

            allowed_params = remove_params(Entities::Post.documentation.keys, :featured_media, :tile_media, :media, :industries, :categories) + [:category_ids, :industry_ids, :author_id]

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
            if params[:tag_list]
              post.tag_list = params[:tag_list]
            end
            post.update!(declared(params, {include_missing: false}, allowed_params))

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

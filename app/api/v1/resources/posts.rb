module V1
  module Resources
    class Posts < Grape::API
      helpers ::V1::Helpers::SharedParamsHelper
      helpers ::V1::Helpers::ParamsHelper

      resource :posts do
        include Grape::Kaminari
        helpers ::V1::Helpers::PostsHelper

        paginate per_page: 25

        desc 'Show all posts', { entity: ::V1::Entities::Post, nickname: "showAllPosts" }
        params do
          use :search
          use :post_metadata
          use :pagination
        end
        get do
          require_scope! 'view:posts'
          authorize! :view, ::Post
          @posts = ::GetPosts.call(params: declared(clean_params(params), include_missing: false), tenant: current_tenant).posts
          ::V1::Entities::Post.represent paginate(@posts).records
        end

        desc 'Show published posts', { entity: ::V1::Entities::Post, nickname: "postFeed" }
        params do
          use :search
          use :post_metadata
          use :pagination
        end
        get 'feed' do
          require_scope! 'view:posts'
          authorize! :view, ::Post
          last_updated_at = Post.last_updated_at
          params_hash     = Digest::MD5.hexdigest(declared(params).to_s)
          cache_key       = "feed-#{last_updated_at}-#{current_tenant.id}-#{params_hash}"

          posts = ::Rails.cache.fetch(cache_key, expires_in: 30.minutes, race_condition_ttl: 10) do
            posts = ::GetPosts.call(params: declared(clean_params(params), include_missing: false), tenant: current_tenant, published: true).posts
            paginated_posts = paginate(posts).records.to_a
            {records: paginated_posts, headers: header}
          end

          header.merge!(posts[:headers])
          ::V1::Entities::Post.represent posts[:records]
        end

        desc 'Show all published posts', { entity: ::V1::Entities::Post, nickname: "allPostFeed" }
        paginate per_page: 10000
        get 'feed/all_posts' do
          require_scope! 'view:posts'
          authorize! :view, ::Post

          posts = ::GetPosts.call(params: declared(clean_params(params), include_missing: false), tenant: current_tenant, published: true).posts
          ::V1::Entities::Post.represent paginate(posts).records
        end

        desc 'Show published post authors'
        get 'feed/authors' do
          present Author.published.distinct, with: ::V1::Entities::Author
        end

        desc 'Show related published posts', { entity: ::V1::Entities::Post, nickname: "relatedPosts" }
        paginate per_page: 5
        get 'feed/:id/related' do
          require_scope! 'view:posts'
          post = GetPost.call(id: params[:id], published: true).post
          not_found! unless post
          authorize! :view, post

          @posts = ::GetRelatedPosts.call(post: post, params: declared(clean_params(params), include_missing: false), tenant: current_tenant, published: true).posts
          ::V1::Entities::Post.represent paginate(@posts).records
        end

        desc 'Show a published post', { entity: ::V1::Entities::Post, nickname: "showFeedPost" }
        get 'feed/*id' do
          @post = ::GetPost.call(id: params[:id], published: true, tenant: current_tenant.id).post
          not_found! unless @post
          authorize! :view, @post
          present @post, with: ::V1::Entities::Post, full: true
        end

        desc 'Show post tags'
        params do
          optional :s
        end
        get 'tags' do
          require_scope! 'view:posts'
          authorize! :view, Post

          tags = params[:s] \
            ? ::Post.tag_counts_on(:tags).where('name ILIKE ?', "%#{params[:s]}%") \
            : ::Post.tag_counts_on(:tags)

          if params[:popular]
            tags = tags.order('count DESC').limit(20)
          end

          present tags, with: ::V1::Entities::Tag
        end

        desc 'Show all filters/facets for posts', { nickname: "showFilters" }
        params do
          optional :depth, default: 1, desc: "Minimum depth of filters"
        end
        get 'filters' do
          require_scope! 'view:posts'
          authorize! :view, Post
          present :industries, ::Onet::Occupation.industries, with: ::V1::Entities::Occupation
          present :categories, ::Category.where('depth >= ?', params[:depth]), with: ::V1::Entities::Category
          present :job_phases, ::Category.roots, with: ::V1::Entities::Category, children: true
        end

        desc 'Show a post', { entity: ::V1::Entities::Post, nickname: "showPost" }
        get ':id' do
          require_scope! 'view:posts'
          @post = ::GetPost.call(id: params[:id], tenant: current_tenant.id).post
          not_found! unless @post
          authorize! :view, @post
          present @post, with: ::V1::Entities::Post, full: true
        end

        desc 'Create a post', { entity: ::V1::Entities::Post, params: ::V1::Entities::Post.documentation, nickname: "createPost" }
        params do
          use :post_associations
        end
        post do
          require_scope! 'modify:posts'
          authorize! :create, Post

          allowed_params = remove_params(::V1::Entities::Post.documentation.keys, :featured_media, :tile_media, :media, :industries, :categories, :is_published, :carotene) + [:category_ids, :industry_ids, :author_id, :carotene_id]

          @post = ::Post.new(declared(params, {include_missing: false}, allowed_params))
          post.user = params[:user] ? User.find(params[:user]) : current_user
          post.save!
          present post, with: ::V1::Entities::Post, full: true
        end

        desc 'Update a post', { entity: ::V1::Entities::Post, params: ::V1::Entities::Post.documentation, nickname: "updatePost" }
        params do
          use :post_associations
        end
        put ':id' do
          require_scope! 'modify:posts'
          authorize! :update, post!

          allowed_params = remove_params(::V1::Entities::Post.documentation.keys, :featured_media, :tile_media, :media, :industries, :categories, :is_published, :carotene) + [:category_ids, :industry_ids, :author_id, :carotene_id]

          if params[:type]
            post.update!({type: params[:type]}) if params[:type]
            reload_post
          end
          if params[:tag_list]
            post.tag_list = params[:tag_list]
          end
          if params[:seo_keyword_list]
            post.seo_keyword_list = params[:seo_keyword_list]
          end
          post.update!(declared(params, {include_missing: false}, allowed_params))

          present post, with: ::V1::Entities::Post, full: true
        end

        desc 'Delete a post', { nickname: "deletePost" }
        delete ':id' do
          require_scope! 'modify:posts'
          authorize! :delete, post!

          post.destroy
        end
      end
    end
  end
end

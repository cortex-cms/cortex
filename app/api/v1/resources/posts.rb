require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    module PostParams
      extend Grape::API::Helpers

      params :post_params do
        optional :title
        optional :type
        optional :published_at
        optional :expired_at
        optional :deleted_at
        optional :draft
        optional :body
        optional :short_description
        optional :job_phase
        optional :display
        optional :featured_media_id
        optional :tile_media_id
        optional :notes
        optional :copyright_owner
        optional :seo_title
        optional :seo_description
        optional :seo_preview
        optional :author
        optional :tag_list
        optional :primary_category_id
        optional :category_ids
        optional :slug
        optional :primary_industry_id
        optional :industry_ids
        optional :destination_url
        optional :call_to_action
      end
    end

    class Posts < Grape::API
      helpers PostParams
      helpers Helpers::SharedParams

      resource :posts do
        helpers Helpers::PaginationHelper
        helpers Helpers::PostsHelper

        desc 'Show all posts'
        params do
          use :pagination
        end
        get do
          require_scope! :'view:posts'
          authorize! :view, ::Post

          q = params[:q]
          if q.to_s != ''
            @posts = ::Post.search_with_params(params).page(page).per(per_page).records
          else
            @posts = Post.order(created_at: :desc).page(page).per(per_page)
          end

          set_pagination_headers(@posts, 'posts')
          present @posts, with: Entities::Post
        end

        desc 'Show published posts'
        params do
          use :pagination
        end
        get 'feed' do
          @posts = Post.search_with_params(params, true).page(page).per(per_page).records
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
            ? Post.tag_counts_on(:tags).where('name ILIKE ?', "%#{params[:s]}%") \
            : Post.tag_counts_on(:tags)

          if params[:popular]
            tags = tags.order('count DESC').limit(20)
          end

          present tags, with: Entities::Tag
        end

        desc 'Show all filters/facets for posts'
        get 'filters' do
          present :industries, ::Onet::Occupation.industries, with: Entities::Occupation
          present :categories, ::Category.all, with: Entities::Category
        end

        desc 'Show a post'
        get ':id' do
          require_scope! :'view:posts'
          authorize! :view, post!

          present post, with: Entities::Post
        end

        desc 'Show related published posts'
        get 'feed/:id/related' do
          @posts = published_post!.related(true).page(page).per(per_page).records
          set_pagination_headers(@posts, 'posts')
          present @posts, with: Entities::PostBasic
        end

        desc 'Create a post'
        params do
          use :post_params
        end
        post do
          require_scope! :'modify:posts'
          authorize! :create, Post

          params[:post_type] = "Promo" if params[:type] == 'promo'
          @post = ::Post.new(declared(params, {include_missing: false}))
          post.user = current_user
          post.save!
          present post, with: Entities::Post
        end

        desc 'Update a post'
        params do
          use :post_params
        end
        put ':id' do
          require_scope! :'modify:posts'
          authorize! :update, post!

          if params[:type]
            post.update!({type: params[:type]}) if params[:type]
            reload_post
          end
          post.update!(declared(params, {include_missing: false}))

          if params[:tag_list]
            post.tag_list = params[:tag_list]
            post.save!
          end

          present post, with: Entities::Post
        end

        desc 'Delete a post'
        delete ':id' do
          require_scope! :'modify:posts'
          authorize! :delete, post!

          post.destroy
        end
      end
    end
  end
end

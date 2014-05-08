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
        optional :featured_image_url
        optional :notes
        optional :copyright_owner
        optional :seo_title
        optional :seo_description
        optional :seo_preview
        optional :author
        optional :tag_list
        optional :category_ids
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
          authorize! :view, Post

          present Post.page(page).per(per_page), with: Entities::Post
        end

        desc 'Show published posts'
        params do
          use :pagination
        end
        get 'feed' do
          @posts = Post.
              includes(:categories).
              published.
              order(published_at: :desc, created_at: :desc).
              page(page).per(per_page)

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

          present tags, with: Entities::Tag
        end

        desc 'Show a post'
        get ':id' do
          require_scope! :'view:posts'
          authorize! :view, Post

          present Post.find(params[:id]), with: Entities::Post
        end

        desc 'Create a post'
        params do
          use :post_params
        end
        post do
          require_scope! :'modify:posts'
          authorize! :create, Post

          @post = ::Post.new(declared(params))
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

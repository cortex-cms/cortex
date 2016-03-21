module API
  module V1
    module Helpers
      module PostsHelper
        include ActsAsTaggableOn::TagsHelper

        def post
          @post ||= ::GetPost.call(id: params[:id], tenant: current_tenant.id).post
        end

        def reload_post
          @post = ::GetPost.call(id: params[:id], tenant: current_tenant.id).post
        end

        def published_post
          @post = ::GetPost.call(id: params[:id], tenant: current_tenant.id, published: true).post
        end

        def post!
          post || not_found!
        end

        def published_post!
          published_post || not_found!
        end
      end
    end
  end
end

module API::V1
  module Helpers
    module PostsHelper
      include ActsAsTaggableOn::TagsHelper

      def post
        @post ||= Post.find_by_id_or_slug(params[:id])
      end

      def reload_post
        @post = Post.find_by_id_or_slug(params[:id])
      end

      def published_post
        @post ||= Post.published.find_by_id_or_slug(params[:id])
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

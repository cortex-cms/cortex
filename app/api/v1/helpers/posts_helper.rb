module API
  module V1
    module Helpers
      module PostsHelper
        include ActsAsTaggableOn::TagsHelper

        def post
          @post ||= ::Post.find_by_id_or_slug(params[:id])
        end

        def reload_post
          @post = ::Post.find_by_id_or_slug(params[:id])
        end

        def published_post
          @post = ::Post.published.find_by_id_or_slug(params[:id])
        end

        def post!
          post || not_found!
        end

        def published_post!
          published_post || not_found!
        end

        def params_has_search?
          Array(params.keys & %w{q categories industries type job_phase post_type author}).length > 0
        end

        def post_params
          clean_params(params)
        end
      end
    end
  end
end

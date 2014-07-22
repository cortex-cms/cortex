require_relative 'post_basic'

module API::V1
  module Entities
    class Post < PostBasic
      expose :media, with: 'Entities::Media', documentation: {type: "Media", is_array: true, desc: "All Media for this post"}

      expose(:display, {documentation: { type: "String", desc: "Post display type" } }) do |post|
        post.display
      end

      expose :tag_list, documentation: {type: "String", is_array: true, desc: "Tags"}

      expose :user, with: 'Entities::UserBasic'
    end
  end
end

require_relative 'post_basic'

module API::V1
  module Entities
    class Post < PostBasic
      expose :media, with: 'Entities::MediaBasic', documentation: {type: "Media", is_array: true, desc: "All Media for this post"}

      expose(:display) do |post|
        post.display
      end

      # expose :tag_list do |post|
      #   post.tag_list.to_a
      # end

      expose :tag_list

      expose :user, with: 'Entities::UserBasic'
    end
  end
end

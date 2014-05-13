require_relative 'post_basic'

module API::V1
  module Entities
    class Post < PostBasic
      expose :media

      expose(:display) do |post|
        post.display
      end

      expose(:tag_list)
      expose :user, with: 'Entities::UserBasic'
    end
  end
end

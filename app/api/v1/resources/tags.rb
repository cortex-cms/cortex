require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    class Tags < Grape::API

      resource :tags do

        desc 'Return an array of all the tags'
        get do
          @tags = Post.tag_counts_on(:tags)
          present @tags, with: Entities::Tag
        end

      end
    end
  end
end

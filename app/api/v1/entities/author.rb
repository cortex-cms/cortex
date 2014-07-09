module API::V1
  module Entities
    class Author < Grape::Entity
      expose :name, :email, :title, :bio, :personal, :twitter, :facebook, :google, :avatars
    end
  end
end

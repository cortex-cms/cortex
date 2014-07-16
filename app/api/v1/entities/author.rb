module API::V1
  module Entities
    class Author < Grape::Entity
      expose :firstname, :lastname, :email, :title, :bio, :personal, :twitter, :facebook, :google,
             :avatars, :fullname
    end
  end
end

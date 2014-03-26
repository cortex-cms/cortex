module API::V1
  module Entities
    class UserProfile < Grape::Entity
      expose :career_status
    end
  end
end

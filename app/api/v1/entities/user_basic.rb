module API::V1
  module Entities
    class UserBasic < Grape::Entity
      expose :id, :fullname
    end
  end
end

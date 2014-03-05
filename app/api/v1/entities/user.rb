require_relative 'user_basic'

module API::V1
  module Entities
    class User < UserBasic
      expose :email, :created_at, :updated_at, :tenant_id, :sign_in_count, :firstname, :lastname, :fullname
    end
  end
end

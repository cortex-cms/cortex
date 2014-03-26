require 'digest/md5'
require_relative 'user_basic'
require_relative 'user_profile'

module API::V1
  module Entities
    class User < UserBasic
      expose :email, :created_at, :updated_at, :sign_in_count, :firstname, :lastname, :fullname, :tenant_id

      expose :profile, using: UserProfile

      expose :gravatar do |user|
        "//www.gravatar.com/avatar/#{Digest::MD5.hexdigest user.email}"
      end
    end
  end
end

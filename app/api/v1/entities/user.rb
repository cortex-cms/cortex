require 'digest/md5'

module V1
  module Entities
    class User < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "User ID" }
      expose :fullname, documentation: { type: "String", desc: "User's full name" }
      with_options if: { full: true } do
        expose :email, documentation: { type: "String", desc: "User Email" }
        expose :admin, documentation: { type: "Boolean", desc: "Is User Admin?" }
        expose :created_at, documentation: { type: 'dateTime', desc: "Created Date" }
        expose :updated_at, documentation: { type: 'dateTime', desc: "Updated Date" }
        expose :sign_in_count, documentation: { type: "Integer", desc: "Sign in Count" }
        expose :firstname, documentation: { type: "String", desc: "User First Name" }
        expose :lastname, documentation: { type: "String", desc: "User Last Name" }
        expose :tenant_id, documentation: { type: "Integer", desc: "User Tenant ID" }

        expose :gravatar, documentation: { type: "String", desc: "Gravatar URL" } do |user|
          "//www.gravatar.com/avatar/#{Digest::MD5.hexdigest user.email}"
        end
      end
    end
  end
end

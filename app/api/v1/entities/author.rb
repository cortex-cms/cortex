module V1
  module Entities
    class Author < Grape::Entity
      expose :firstname, documentation: { type: "String", desc: "First Name" }
      expose :lastname, documentation: { type: "String", desc: "Last Name" }
      expose :email, documentation: { type: "String", desc: "Email" }
      expose :title, documentation: { type: "String", desc: "Title" }
      expose :bio, documentation: { type: "String", desc: "Bio" }
      expose :personal, documentation: { type: "String", desc: "Personal Website" }
      expose :twitter, documentation: { type: "String", desc: "Twitter Profile" }
      expose :facebook, documentation: { type: "String", desc: "Facebook Profile" }
      expose :google, documentation: { type: "String", desc: "Google Profile" }
      expose :avatars, documentation: { type: "String", desc: "Avatar" }
      expose :fullname, documentation: { type: "String", desc: "Full Name" }
      expose :id, documentation: { type: "Integer", desc: "Author ID" }
    end
  end
end

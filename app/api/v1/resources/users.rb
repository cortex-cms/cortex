require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    class Users < Grape::API

      resource :users do
        helpers Helpers::UsersHelper

        desc 'Get the current user'
        get :me do
          authorize! :view, current_user!
          present current_user, with: Entities::User
        end

        desc "Fetch a user's author info"
        get ':user_id/author' do
          require_scope! :'view:users'
          authorize! :view, user!

          present user.author || not_found!, with: Entities::Author
        end

        desc "Save a user's author info"
        params do
          optional :email
          optional :firstname
          optional :lastname
          optional :personal
          optional :facebook
          optional :twitter
          optional :google
          optional :bio
        end
        put ':user_id/author' do
          require_scope! :'modify:users'
          authorize! :update, user!

          author = Author.find_or_create_by(user_id: params[:user_id])
          author.update_attributes!(declared(params, {include_missing: false}))
          author.save!

          present author, with: Entities::Author
        end

        desc 'Show a user'
        get ':user_id' do
          require_scope! :'view:users'
          authorize! :view, user!

          present user, with: Entities::User
        end
      end
    end
  end
end

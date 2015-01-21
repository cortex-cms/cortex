require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Users < Grape::API

        resource :users do
          helpers Helpers::UsersHelper

          desc 'Get the current user', { entity: Entities::User, nickname: "currentUser" }
          get :me do
            authorize! :view, current_user!
            present current_user, with: Entities::User, full: true
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

          desc "Create a new user"
          params do
            optional :email
            optional :firstname
            optional :lastname
            optional :tenant_id
            optional :password
            optional :password_confirmation
          end
          post do
            require_scope! :'modify:users'
            authorize! :create, User

            allowed_params = [:password, :password_confirmation, :firstname, :lastname, :email, :tenant_id, :admin]

            @user = User.create!(declared(params, {include_missing: false}, allowed_params))

            present @user, with: Entities::User, full: true
          end

          desc "Save a user's info"
          params do
            optional :current_password
            optional :password
            optional :password_confirmation
            optional :firstname
            optional :lastname
          end
          put ':user_id' do
            require_scope! :'modify:users'
            authorize! :update, user!

            allowed_params = [:firstname, :lastname, :gravatar]

            if user == current_user
              forbidden! unless user.valid_password?(params[:current_password])
              allowed_params += [:password, :password_confirmation]
              render_api_error!("Requires both password and password_confirmation fields", 422) unless params[:password] && params[:password_confirmation]
            end

            user.update!(declared(params, {include_missing: false}, allowed_params))
            user.save!

            present user, with: Entities::User, full: true
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
end

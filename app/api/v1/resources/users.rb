require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Users < Grape::API

        resource :users do
          helpers Helpers::UsersHelper
          helpers Helpers::BulkJobsHelper

          desc 'Reset password'
          params do
            requires :email
          end
          post 'reset_password' do
            user = User.where email: params[:email]
            status 404 unless user.present?
          end

          desc 'Get the current user', { entity: Entities::User, nickname: 'currentUser' }
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

          desc 'Create a new user'
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
            optional :email
            optional :admin
          end
          put ':user_id' do
            require_scope! :'modify:users'
            authorize! :update, user!

            allowed_params = [:firstname, :lastname]

            if current_user.is_admin?
              allowed_params += [:email, :admin]
            elsif user == current_user
              forbidden! unless user.valid_password?(params[:current_password])
              allowed_params += [:password, :password_confirmation]
              render_api_error!('Requires both password and password_confirmation fields', 422) unless params[:password] && params[:password_confirmation]
            end

            user.update!(declared(params, {include_missing: false}, allowed_params))

            present user, with: Entities::User, full: true
          end

          desc 'Show a user', {nickname: 'showUser'}
          get ':user_id' do
            require_scope! :'view:users'
            authorize! :view, user!

            present user, with: Entities::User, full: true
          end

          desc 'Delete a user', {nickname: 'deleteUser'}
          delete ':user_id' do
            require_scope! :'modify:users'
            authorize! :delete, user!

            begin
              user.destroy
            rescue Cortex::Exceptions::ResourceConsumed => e
              error!({
                       error:   'Conflict',
                       message: e.message,
                       status:  409
                     }, 409)
            end
          end

          desc 'Bulk create users', { entity: Entities::BulkJob, nickname: 'bulkCreateUsers' }
          post :bulk_job do
            require_scope! :'modify:users'
            require_scope! :'modify:bulk_jobs'
            authorize! :create, ::User
            authorize! :create, ::BulkJob

            bulk_job_params = params[:bulkJob] || params

            @bulk_job = ::BulkJob.new(declared(bulk_job_params, { include_missing: false }, Entities::BulkJob.documentation.keys))
            bulk_job.content_type = 'Users'
            bulk_job.user = current_user!
            bulk_job.save!

            BulkCreateUsersJob.perform_later(bulk_job)

            present bulk_job, with: Entities::BulkJob
          end
        end
      end
    end
  end
end

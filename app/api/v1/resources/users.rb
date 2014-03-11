require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    class Users < Grape::API

      resource :users do

        desc 'Get the current user'
        get :me do
          authorize! :view, current_user!
          present current_user, with: Entities::User
        end

        desc 'Update the current user'
        params do
          # ??
        end
        put :me do
          # ??
        end
      end
    end
  end
end

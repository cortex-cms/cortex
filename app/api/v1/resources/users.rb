require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    class Users < Grape::API

      resource :users do

        desc 'Get the current user', { entity: Entities::User, nickname: "currentUser" }
        get :me do
          authorize! :view, current_user!
          present current_user, with: Entities::User, full: true
        end
      end
    end
  end
end

require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    class Occupations < Grape::API

      resource :occupations do

        desc 'Show all occupations', { entity: Entities::Occupation }
        get do
          present ::Onet::Occupation.all, with: Entities::Occupation
        end

        desc 'Show all industries', { entity: Entities::Occupation }
        get :industries do
          present ::Onet::Occupation.industries, with: Entities::Occupation
        end
      end
    end
  end
end

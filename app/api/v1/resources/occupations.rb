require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Occupations < Grape::API
        doorkeeper_for :all, scopes: [:public]

        resource :occupations do

          desc 'Show all occupations', { entity: Entities::Occupation, nickname: "showAllOccupations" }
          get do
            present ::Onet::Occupation.all, with: Entities::Occupation
          end

          desc 'Show all industries', { entity: Entities::Occupation, nickname: "showAllIndustries" }
          get :industries do
            present ::Onet::Occupation.industries, with: Entities::Occupation
          end
        end
      end
    end
  end
end

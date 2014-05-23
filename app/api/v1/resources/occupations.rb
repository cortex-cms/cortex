require_relative '../helpers/resource_helper'

module API::V1
  module Resources
    class Occupations < Grape::API

      resource :occupations do

        desc 'Show all occupations'
        get do
          authorize! :view, Category
          present Onet::Occupation.all, with: Entities::Occupation
        end

        desc 'Show all industries'
        get :industries do
          present Onet::Occupation.industries, with: Entities::Occupation
        end
      end
    end
  end
end

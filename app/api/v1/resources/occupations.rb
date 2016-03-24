module V1
  module Resources
    class Occupations < Grape::API
      resource :occupations do
        desc 'Show all occupations', { entity: ::V1::Entities::Occupation, nickname: "showAllOccupations" }
        get do
          present ::Onet::Occupation.all, with: ::V1::Entities::Occupation
        end

        desc 'Show all industries', { entity: ::V1::Entities::Occupation, nickname: "showAllIndustries" }
        get :industries do
          present ::Onet::Occupation.industries, with: ::V1::Entities::Occupation
        end
      end
    end
  end
end

module V1
  module Resources
    class Carotenes < Grape::API
      resource :carotenes do
        include Grape::Kaminari
        helpers ::V1::Helpers::CarotenesHelper

        paginate per_page: 25

        desc 'Show all Carotene codes', { entity: ::V1::Entities::Carotene, nickname: 'showAllCarotene' }
        get do
          authorize! :view, ::Carotene

          @carotene = ::Carotene.all
          ::V1::Entities::Carotene.represent @carotene
        end

        desc 'Get carotene by ID', { entity: ::V1::Entities::Carotene, nickname: 'showCarotene' }
        get ':id' do
          authorize! :view, carotene!

          present carotene, with: ::V1::Entities::Carotene
        end
      end
    end
  end
end

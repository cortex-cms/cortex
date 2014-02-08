module API; end

Dir["#{Rails.root}/app/api/v1/**/*.rb"].each {|file| require file}
require "#{Rails.root}/lib/pagination_headers"

module API
  module V1
    class API < Grape::API
      version 'v1', using: :path
      format :json

      helpers Helpers::APIHelper
      helpers PaginationHeaders

      mount Resources::Categories
      mount Resources::Media
      mount Resources::Posts
      mount Resources::Tenants
      mount Resources::Users
    end
  end
end

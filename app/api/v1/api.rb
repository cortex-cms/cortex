module API; end

Dir["#{Rails.root}/app/api/v1/**/*.rb"].each {|file| require file}
require "#{Rails.root}/lib/pagination_headers"

module API
  module V1
    class API < Grape::API
      version 'v1', using: :path
      format :json

      rescue_from ActiveRecord::RecordInvalid do |ex|
        errors = ex.record.errors.map{ |attr, error| "#{attr} #{error}" }
        rack_response({message: 'Validation failed', errors: errors}, 422)
      end

      helpers Helpers::APIHelper
      helpers PaginationHeaders

      mount Resources::Categories
      mount Resources::Media
      mount Resources::Posts
      mount Resources::Tenants
      mount Resources::Users

      add_swagger_documentation
    end
  end
end

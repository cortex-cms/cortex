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
        rack_response({message: 'Validation failed', errors: errors}.to_json, 422)
      end

      helpers Helpers::APIHelper
      helpers PaginationHeaders

      mount Resources::Categories
      mount Resources::Posts
      mount Resources::Media
      mount Resources::Tenants
      mount Resources::Users
      mount Resources::Occupations

      add_swagger_documentation(base_path: '/api', hide_format: true, api_version: 'v1', models: [Entities::Post, Entities::Category, Entities::Media, Entities::Tenant, Entities::Occupation, Entities::User])
    end
  end
end

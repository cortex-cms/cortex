require 'cortex/exceptions'
require "#{Rails.root}/lib/pagination_headers"

# Load modules in order
Dir["#{Rails.root}/app/api/v1/entities/*.rb"].each {|file| require file}
Dir["#{Rails.root}/app/api/v1/helpers/*.rb"].each {|file| require file}
Dir["#{Rails.root}/app/api/v1/resources/*.rb"].each {|file| require file}

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
      mount Resources::Localizations
      mount Resources::Locales
      mount Resources::Applications
      mount Resources::Credentials
      mount Resources::BulkJobs

      add_swagger_documentation(base_path: '/api', hide_format: true, api_version: 'v1',
                                models: [Entities::Post, Entities::Category, Entities::Media,
                                         Entities::Tenant, Entities::Occupation, Entities::User,
                                         Entities::Localization, Entities::Locale,
                                         Entities::Application, Entities::Credential,
                                         Entities::BulkJob])
    end
  end
end

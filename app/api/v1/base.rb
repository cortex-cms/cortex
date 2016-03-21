require_relative '../oauth'
require 'cortex/exceptions'

# Load modules in order
Dir["#{Rails.root}/app/api/v1/entities/*.rb"].each {|file| require file}
Dir["#{Rails.root}/app/api/v1/helpers/*.rb"].each {|file| require file}
Dir["#{Rails.root}/app/api/v1/resources/*.rb"].each {|file| require file}

module API
  module V1
    class Base < Grape::API
      default_format :json
      default_error_formatter :json
      format :json
      content_type :json, 'application/json'
      version 'v1', using: :path

      helpers Helpers::APIHelper
      include API::OAuth

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
      mount Resources::Documents
      mount Resources::Snippets
      mount Resources::Webpages

      add_swagger_documentation(base_path: '/api', hide_format: true, api_version: 'v1',
                                models: [Entities::Post, Entities::Category, Entities::Media,
                                         Entities::Tenant, Entities::Occupation, Entities::User,
                                         Entities::Localization, Entities::Locale,
                                         Entities::Application, Entities::Credential,
                                         Entities::BulkJob, Entities::Document, Entities::Snippet,
                                         Entities::Webpage])
    end
  end
end

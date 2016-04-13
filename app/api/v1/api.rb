module V1
  class API < Grape::API
    default_format :json
    default_error_formatter :json
    format :json
    content_type :json, 'application/json'
    version 'v1', using: :path

    helpers ::V1::Helpers::APIHelper

    mount ::V1::Resources::Categories
    mount ::V1::Resources::Posts
    mount ::V1::Resources::Media
    mount ::V1::Resources::Tenants
    mount ::V1::Resources::Users
    mount ::V1::Resources::Occupations
    mount ::V1::Resources::Localizations
    mount ::V1::Resources::Locales
    mount ::V1::Resources::Applications
    mount ::V1::Resources::Credentials
    mount ::V1::Resources::BulkJobs
    mount ::V1::Resources::Documents
    mount ::V1::Resources::Snippets
    mount ::V1::Resources::Webpages

    add_swagger_documentation(base_path: '/api', hide_format: true, api_version: 'v1',
                              models: [::V1::Entities::Post, ::V1::Entities::Category, ::V1::Entities::Media,
                                       ::V1::Entities::Tenant, ::V1::Entities::Occupation, ::V1::Entities::User,
                                       ::V1::Entities::Localization, ::V1::Entities::Locale,
                                       ::V1::Entities::Application, ::V1::Entities::Credential,
                                       ::V1::Entities::BulkJob, ::V1::Entities::Document, ::V1::Entities::Snippet,
                                       ::V1::Entities::Webpage])
  end
end

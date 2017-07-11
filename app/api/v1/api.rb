module V1
  class API < Grape::API
    default_format :json
    default_error_formatter :json
    format :json
    content_type :json, 'application/json'
    version 'v1', using: :path

    mount ::V1::Resources::Localizations
    mount ::V1::Resources::Locales
    mount ::V1::Resources::Applications
    mount ::V1::Resources::Credentials
    mount ::V1::Resources::ContentTypes
    mount ::V1::Resources::ContentItems

    add_swagger_documentation(base_path: '/api', hide_format: true, api_version: 'v1',
                              models: [::V1::Entities::Localization, ::V1::Entities::Locale,
                                       ::V1::Entities::Application, ::V1::Entities::Credential,
                                       ::V1::Entities::ContentType, ::V1::Entities::ContentItem])
  end
end

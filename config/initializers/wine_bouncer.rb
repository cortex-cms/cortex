WineBouncer.configure do |config|
  config.auth_strategy = :default

  config.define_resource_owner do
    User.find(doorkeeper_access_token.resource_owner_id) if doorkeeper_access_token
  end

  config.disable do
    include Rack::Current
    current_request.env[Rack::OAuth2::Server::Resource::ACCESS_TOKEN].nil?
  end
end

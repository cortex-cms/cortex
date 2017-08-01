class API < Grape::API
  rescue_from ActiveRecord::RecordInvalid do |ex|
    errors = ex.record.errors.map{ |attr, error| "#{attr} #{error}" }
    rack_response({message: 'Validation failed', errors: errors}.to_json, 422)
  end

  rescue_from ArgumentError do |e|
    rack_response({error: "ArgumentError: #{e.message}"}.to_json, 400)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response({error: "ValidationErrors: #{e.message}"}.to_json, 400)
  end

  include ::Helpers::AuthHelper
  helpers ::Helpers::APIHelper
  mount ::V1::API
end

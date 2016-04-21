class API < Grape::API
  rescue_from ActiveRecord::RecordInvalid do |ex|
    errors = ex.record.errors.map{ |attr, error| "#{attr} #{error}" }
    rack_response({message: 'Validation failed', errors: errors}.to_json, 422)
  end

  include ::Helpers::AuthHelper
  helpers ::Helpers::APIHelper
  mount ::V1::API
end

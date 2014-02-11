API = API::V1::API

def represent(entity, obj)
  be_json_eql(entity.new(obj).to_json)
end

def application_json
  {:CONTENT_TYPE => 'application/json'}
end


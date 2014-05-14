API = API::V1::API

def represent(entity, obj)
  obj_json = obj.kind_of?(Array) ? obj.map{ |v| entity.new(v).to_json }.to_json : entity.new(obj).to_json
  be_json_eql(obj_json)
end

def application_json
  {:CONTENT_TYPE => 'application/json'}
end


SPEC_API = API::V1::Base

def represent(entity, obj, opts = {})
  obj_json = obj.kind_of?(Array) ? obj.map{ |v| entity.new(v, opts).to_json }.to_json : entity.new(obj, opts).to_json
  be_json_eql(obj_json)
end

def application_json
  {:CONTENT_TYPE => 'application/json'}
end

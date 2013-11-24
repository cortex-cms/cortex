json.array!(@users) do |user|
  json.extract! user, :name, :password
  json.url user_url(user, format: :json)
end

json.array!(@users) do |user|
  json.extract! user, :username, :password
  json.url user_url(user, format: :json)
end

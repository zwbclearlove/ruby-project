json.extract! user, :id, :username, :nickname, :password, :email, :created_at, :updated_at
json.url user_url(user, format: :json)

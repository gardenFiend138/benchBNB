json.set! :user do
  json.extract! user, :username, :reset_session_token
end

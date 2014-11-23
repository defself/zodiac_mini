def user_login user
  session[:user_id] = user.id
  user.create_session
end

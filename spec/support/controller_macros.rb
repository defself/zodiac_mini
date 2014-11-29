def sign_in user
  user.create_session
  session[:user_id] = user.id
end

def log_out user
  user.session.destroy
  session[:user_id] = nil
end

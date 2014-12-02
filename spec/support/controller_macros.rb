def sign_in user
  if user && user.session.nil?
    user.create_session
    session[:user_id] = user.id
  end
end

def sign_out user
  if user && user.session
    user.session.destroy
    session[:user_id] = nil
  end
end

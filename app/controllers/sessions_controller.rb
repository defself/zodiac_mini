class SessionsController < ApplicationController
  before_filter :authenticate_user, except: [:new, :create]
  before_filter :redirect_to_root, only: :new

  def new
    @session = Session.new
  end

  def create
    @user = User.find_by_email_and_password(session_params[:email], session_params[:password])
    if @user
      @user.create_session
      session[:user_id] = @user.id
      redirect_to user_path(@user), success: "User signed in successfully"
    else
      redirect_to new_session_path, error: "User not found"
    end
  end

  def destroy
    user = User.find_by id: params[:id]
    user.session.destroy
    session[:user_id] = nil
    redirect_to new_session_path, success: "User logged out"
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def redirect_to_root
    redirect_to users_path if current_user?
  end
end

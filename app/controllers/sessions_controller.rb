class SessionsController < ApplicationController
  before_filter :authenticate_user, except: [:new, :create]
  before_filter :redirect_to_root, only: :new

  def new
    @session = Session.new
  end

  def create
    @user = User.find_by session_params
    if @user
      @user.create_session
      session[:user_id] = @user.id
      redirect_to user_path(@user), success: "User signed in successfully"
    else
      @session = Session.new
      flash[:error] = "User not found"
      render new_session_path
    end
  end

  def destroy
    user = User.find_by id: params[:id]
    if user && user.session.destroy
      session[:user_id] = nil
      redirect_to new_session_path, success: "User have been logged out"
    else
      redirect_to root_path, error: "User haven't been logged out"
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def redirect_to_root
    redirect_to users_path if current_user?
  end
end

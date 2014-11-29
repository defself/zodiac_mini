class UsersController < ApplicationController
  before_filter :authenticate_user, except: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user      = User.find_by id: params[:id]
    @yesterday = @user.horoscopes.yesterday
    @today     = @user.horoscopes.today
    @tomorrow  = @user.horoscopes.tomorrow
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.create_session
      session[:user_id] = @user.id
      redirect_to @user, success: "User signed up successfully"
    else
      flash[:error] = @user.errors.full_messages
      render new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :birthday, :password, :password_confirmation)
  end
end

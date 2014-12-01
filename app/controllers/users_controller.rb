class UsersController < ApplicationController
  before_filter :authenticate_user, except: [:new, :create]
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @users = User.all
    render json: { users: @users }
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    render json: { user: @user }
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.create_session
      session[:user_id] = @user.id
      render json: { user: @user }
    else
      flash[:error] = @user.errors.full_messages
      render json: { error: @user.errors.full_messages }, status: 422
    end
  end

  def horoscope
    @user      = User.find_by id: params[:user_id]
    @horoscope = @user.horoscopes.send(params[:type])
    render json: { horoscope: [@horoscope] }
  end

  private

  def user_params
    params.require(:user).permit(:email, :birthday, :password, :password_confirmation)
  end

end

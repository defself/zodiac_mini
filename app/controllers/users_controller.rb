class UsersController < ApplicationController
  before_filter :authenticate_user, except: [:new, :create]
  before_filter :redirect_to_root, only: :new
  skip_before_action :verify_authenticity_token, only: [:create]
  respond_to :html, :json

  def index
    @users = User.order :birthday
    respond_with @users
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    respond_with @user, root: true
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.create_session
      session[:user_id] = @user.id
      flash[:success] = "User registered successfully"
      respond_with @user, root: true
    else
      flash[:error] = @user.errors.full_messages
      render json: { error: flash[:error] }, status: 422
    end
  end

  def horoscope
    @user      = User.find_by id: params[:user_id]
    @horoscope = Horoscope.send(params[:type], @user.zodiac.id)
    render json: { horoscope: [@horoscope] }
  end

  private

  def user_params
    params.require(:user).permit(:email, :birthday, :password, :password_confirmation)
  end

  def redirect_to_root
    redirect_to users_path if signed_in?
  end
end

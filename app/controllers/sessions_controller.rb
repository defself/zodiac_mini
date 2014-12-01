class SessionsController < ApplicationController
  before_filter :authenticate_user, except: [:new, :create]
  before_filter :redirect_to_root, only: :new
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def new
    @session = Session.new
  end

  def show
    @user = User.find_by id: params[:id]
    render json: { session: @user.session }
  end

  def create
    @user = User.find_by session_params
    if @user
      @user.create_session
      session[:user_id] = @user.id
      render json: { session: @user }
    else
      @session = Session.new
      flash[:error] = "User not found"
      render json: { error: "User not found" }, status: 422
    end
  end

  def destroy
    if @current_user.session.destroy
      session[:user_id] = nil
      render json: { success: "User have been logged out" }
    else
      render json: { error: "User haven't been logged out" }, status: 422
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

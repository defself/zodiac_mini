class SessionsController < ApplicationController
  before_filter :authenticate_user, except: [:new, :create]
  before_filter :redirect_to_root, only: :new
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]
  respond_to :html, :json

  def new
    @session = Session.new
  end

  def show
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { respond_with @current_user.session, root: true }
    end
  end

  def create
    @user = User.find_by session_params
    if @user
      @user.create_session
      session[:user_id] = @user.id
      flash[:success] = "User logged in successfully"
      render json: { session: @user }
    else
      @session = Session.new
      flash[:error] = "User not found"
      render json: { error: flash[:error] }, status: 422
    end
  end

  def destroy
    if @current_user && @current_user.session.destroy
      session[:user_id] = nil
      flash[:success] = "User have been logged out"
      render json: { success: flash[:success] }
    else
      flash[:error] = "User haven't been logged out"
      render json: { error: flash[:error] }, status: 422
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def redirect_to_root
    redirect_to users_path if signed_in?
  end
end

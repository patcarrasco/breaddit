class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update delete]

  def index
    @users = User.all
  end

  def new
    flash[:errors] = nil
    @user = User.new
  end

  def create
    @user = User.new(strong_params)
    if @user.save
      redirect_to new_session_path
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @posts = @user.posts
  end

  def edit
    @session_user = User.where("id = #{session[:user_id]}").first
    if @session_user && @session_user.password_digest == @user.password_digest
      render :edit
    else
      redirect_to account_path
    end
  end

  def update
    @user.update(strong_params)
    if @user.valid?
      redirect_to account_path
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end


  def follow
    @post_user = User.find(params[:id])
    @session_user = User.find(session[:user_id])
    if @session_user.find_follow(@post_user.id)
      @session_user.unfollow_user(@post_user.id)
      redirect_back(fallback_location: posts_path)
    else
      @session_user.follow_user(@post_user.id)
      redirect_back(fallback_location: posts_path)
    end
  end


  private

  def find_user
    @user = User.find(params[:id])
  end

  def strong_params
    params.require(:user).permit(:name, :description, :password, :username)
  end
end

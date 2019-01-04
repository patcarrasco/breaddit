class SessionsController < ApplicationController

  def new
    flash[:errors] = nil
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      log_in!(@user)
      redirect_to posts_path
    else
      flash[:errors] = "username or password does not exist"
      render :new
    end
  end


  def account
    @user = User.find(session[:user_id])
    if @user
      @posts = Post.where("user_id = #{@user.id}").order('created_at DESC').page params[:page]
      render :account
    else
      redirect_to new_session_path
    end
  end

  def delete
    session.clear
    redirect_to posts_path
  end


end

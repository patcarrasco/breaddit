class PostsController < ApplicationController
  before_action :find_post, only: %i[show edit update support destroy]

  def index
    @posts = Post.order('created_at DESC').page params[:page]
  end

  def home
    @user = User.find(session[:user_id])
    ids = @user.following.collect {|u| u.id}
    @posts = Post.where(user_id: ids).order('created_at DESC').page params[:page]
  end

  def new
    @user = User.find(session[:user_id])
    @post = Post.new
  end

  def create
    params[:post][:user_id] = session[:user_id]
    @post = Post.create(post_params)
    if @post.valid?
      redirect_to posts_path
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post_user = User.find(@post.user.id)
    @posts = Post.where("user_id = #{@post_user.id}").order('created_at DESC').limit(5)
    @comment = Comment.new
    @comments = Comment.where("post_id = #{@post.id}").order('created_at DESC')
    if session[:user_id]
      @session_user = User.find(session[:user_id])
      if @session_user.find_like(@post.id).empty?
        @like_message = "like"
      else
        @like_message = "liked"
      end
      if @session_user.find_follow(@post_user.id)
        @follow_message = "unfollow #{@post_user.username}"
      else
        @follow_message = "follow #{@post_user.username}"
      end
    end
  end

  def edit
    @session_user = User.where("id = #{session[:user_id]}").first
    if @session_user && @session_user.password_digest == @post.user.password_digest
      render :edit
    else
      redirect_to account_path
    end
  end

  def update
    @post.update(post_params)
    if @post.valid?
      redirect_to @post
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to account_path
  end

  def support
    @session_user = User.find(session[:user_id])
    if @session_user.find_like(params[:id]).empty?
      @session_user.like_post(params[:id])
      redirect_back(fallback_location: posts_path)
    else
      @session_user.unlike_post(params[:id])
      redirect_back(fallback_location: posts_path)
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :title, :content)
  end

end

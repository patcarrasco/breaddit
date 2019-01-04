class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = Comment.create(comment_params)
    if @comment.valid?
      redirect_back(fallback_location: @post)
    else
      flash[:errors] = @comment.errors.full_messages
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end

class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.link_id = params[:link_id]
    @comment.save

    flash.now[:errors] = @comment.errors.full_messages
    redirect_to link_url(@comment.link_id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to link_url(@comment.link_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

class CommentsController < ApplicationController
  
  def create
   @comment = Comment.new(comment_params)
   @comment.trail_id = params[:trail_id]
   @comment.user_id = current_user.id
   if @comment.save
    redirect_to trail_path(@comment.trail)
   else
     redirect_to root_path
   end
  end

  private

  def comment_params
    params.require(:comment).permit(:star_rating, :body, :user_id)
  end
end

class CommentsController < ApplicationController
  def index

  end
  def new
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.new
  end

  def create
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.build_with_user(comment_params, current_user)
    if @comment.save
    # redirect_to "/users/#{@picture.user_id}/pictures"
      render json: { comment: params[:comment][:content] }
    else
      render :nothing
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end

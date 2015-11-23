class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
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
      render json: { comment: params[:comment][:content], username: current_user.name, userid: current_user.id, delete_path: comment_path(@comment) }
    else
      render nothing: true
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: {}
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end

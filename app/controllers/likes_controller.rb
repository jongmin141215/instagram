class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @picture = Picture.find(params[:picture_id])
    @like = @picture.build_with_user2(current_user)
    if @like.save
      render json: { count: @picture.likes.count }
    else
      redirect_to new_user_session_path
    end
  end
end

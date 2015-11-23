class LikesController < ApplicationController
  def create
    @picture = Picture.find(params[:picture_id])
    @like = @picture.build_with_user2(current_user)
    if @like.save
      render json: { count: @picture.likes.count }
    else
      render nothing: true
    end
  end
end

class PicturesController < ApplicationController
  def index
  end

  def new
    @user = User.find(params[:user_id])
    @picture = @user.pictures.new
  end
end

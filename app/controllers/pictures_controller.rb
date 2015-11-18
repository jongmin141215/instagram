class PicturesController < ApplicationController
  def index
    @pictures = Picture.where(user_id: params[:user_id]) || []
  end

  def new
    @user = User.find(params[:user_id])
    @picture = @user.pictures.new
  end

  def create
    @user = User.find(params[:user_id])
    @picture = @user.pictures.create(picture_params)
    redirect_to user_pictures_path(@user)
  end

  def edit
  end

  def update
    render json: { description: params[:description] }
  end

  private
  def picture_params
    params.require(:picture).permit(:image, :description)
  end
end

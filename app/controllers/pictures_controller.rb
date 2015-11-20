class PicturesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
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
    @picture = Picture.find(params[:id])
    @picture.update(update_params)
    render json: { description: params[:picture][:description] }

  end

  def destroy
    @picture = Picture.find(params[:id])
    @user = @picture.user
    @picture.destroy
    redirect_to user_pictures_path(@user)
  end

  private
  def picture_params
    params.require(:picture).permit(:image, :description)
  end

  def update_params
    params.require(:picture).permit(:description)
  end
end

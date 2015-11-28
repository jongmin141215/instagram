class PicturesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :homepage]
  def index
    @pictures = Picture.where(user_id: params[:user_id]).order("created_at DESC")
    respond_to do |format|
      format.html
      format.json { @users = User.search(params[:term]) }
    end
  end

  def new
    @user = User.find(params[:user_id])
    @picture = @user.pictures.new
  end

  def create
    @user = User.find(params[:user_id])
    @picture = @user.pictures.build(picture_params)
    if @picture.save
      redirect_to user_pictures_path(@user)
    else
      render 'new'
    end
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
    render json: {}
  end

  def homepage
    if current_user
      @user = User.find(current_user.id)
      redirect_to user_pictures_path(@user)
    else
      redirect_to "/users/sign_in"
    end
  end


  private
  def picture_params
    params.require(:picture).permit(:image, :description)
  end

  def update_params
    params.require(:picture).permit(:description)
  end
end

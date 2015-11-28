class UsersController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { @users = User.search(params[:term]) }
    end
  end

  def show
  end
end

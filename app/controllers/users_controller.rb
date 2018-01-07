class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    #只顯示除了自己之外的美食達人
    @users = User.where("id != ?", current_user)
  end

  def show
    @user = User.find(params[:id])
    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants
    @followings = @user.followings
    @followers = @user.followers
  end

  def edit 
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end


  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "User's profile is successfully updated"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "User's profile is failed updated,plaese check it again!"
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end



end



class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    #如果使用者資料未齊全，直接跳往edit頁面進行設定
    unless @user.name? && @user.intro?
      redirect_to edit_user_path(@user)
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
    params.require(:user).permit(:name, :email, :intro)
  end

  def set_user
    @user = User.find(params[:id])
  end



end

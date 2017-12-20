class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    unless @user.name? && @user.intro?
      redirect_to edit_user_path(@user)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

end

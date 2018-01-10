class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id], status: "applying")
    if @friendship.save
      flash[:notice] = "成功申請好友，等待確認！"
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: root_path)
  end

  def update
    @friendship = current_user.inverse_friendships.where(user_id: params[:id], status: "applying").first
    if @friendship.update(status: "accepted")
      flash[:notice] = "成功接受成為好友！"
    else
      flash[:alert] = "Failed to accepted!"
    end

    redirect_back(fallback_location: root_path)
  end
    

  def destroy
    if current_user.friendships.where(friend_id: params[:id], status: "applying").present?
      @friendship = current_user.friendships.where(friend_id: params[:id], status: "applying")
      @friendship.destroy_all
      flash[:notice] = "已取消好友申請"
    elsif current_user.friendships.where(friend_id: params[:id]).present?      
      @friendship = current_user.friendships.where(friend_id: params[:id], status: "accepted")
      @friendship.destroy_all
      flash[:notice] = "成功刪除好友"
    elsif current_user.inverse_friendships.where(user_id: params[:id], status: "applying").present?
      @friendship = current_user.inverse_friendships.where(user_id: params[:id], status: "applying")
      @friendship.destroy_all
      flash[:notice] = "拒絕成為好友"
    end

    redirect_back(fallback_location: root_path)
  end

end

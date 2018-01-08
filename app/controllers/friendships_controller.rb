class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id], status: "applying")
    if @friendship.save
      flash[:notice] = "成功申請好友，等待確認！"
    else
      flash[:alert] = @friend.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: root_path)
  end

  def update
    @friendship = current_user.friendships.where(friend_id: current_user, user_id: params[:id], status: "applying")
    if @friendship.update(status: "accepted")
      flash[:notice] = "成功接受成為好友！"
    else
      flash[:alert] = "Failed to accepted!"
    end

    redirect_back(fallback_location: root_path)
  end
    

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id], status: "applying")
    @friendship.destroy_all
    flash[:notice] = "已取消好友"
    redirect_back(fallback_location: root_path)
  end

end

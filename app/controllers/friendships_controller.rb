class FriendshipsController < ApplicationController

  def create
    @friend = current_user.friendships.new(friend_id: params[:friend_id])
    if @friend.save
      flash[:notice] = "成功加入好友"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friend.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friend = current_user.friendships.where(friend_id: params[:id]).first
    @friend.destroy
    flash[:notice] = "已取消好友"
    redirect_back(fallback_location: root_path)
  end

end

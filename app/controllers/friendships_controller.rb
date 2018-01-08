class FriendshipsController < ApplicationController

  def create
    @applys = current_user.friendships.new(friend_id: params[:friend_id], status: "applying")
    if @applys.save
      flash[:notice] = "成功申請好友，等待確認！"
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

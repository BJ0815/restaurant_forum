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
end

class Friendship < ApplicationRecord
  after_create :inverse_friend

  validates :user_id , uniqueness: { scope: :friend_id }

  belongs_to :user
  belongs_to :friend, class_name: "User"

  private

  def inverse_friend
    Friendship.create(friend_id: user, user_id: friend, status: "applying")
  end


end

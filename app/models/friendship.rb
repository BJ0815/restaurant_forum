class Friendship < ApplicationRecord

  validates :user_id , uniqueness: { scope: :friend_id }

  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_create :inverse_friend, unless: :has_applying_inverse?
  after_destroy :destroy_inverse, if: :has_accepted_inverse?
  after_commit :update_option, on: :update

  private

  def inverse_friend
    self.class.create(inverse_applying_option)
  end

  def destroy_inverse
    inverses.destroy_all
  end

  def update_inverse
    self.class.where(accepted_option)
  end

  def update_option
    update_inverse.update(status: "accepted")
  end

  def has_applying_inverse?
    self.class.exists?(inverse_applying_option)
  end

  def has_accepted_inverse?
    self.class.exists?(inverse_accepted_option)
  end

  def inverses
    self.class.where(inverse_accepted_option)
  end

  def inverse_applying_option
    { friend_id: user_id, user_id: friend_id }
  end

  def inverse_accepted_option
    { friend_id: user_id, friend_id: friend_id, status: "accepted"}
  end

  def accepted_option
    { friend_id: friend_id, user_id: user_id, status: "applying" }
  end

end

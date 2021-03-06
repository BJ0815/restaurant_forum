class User < ApplicationRecord
  #驗證
  validates_presence_of :name, :email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #關聯設定(與comments一對多關係及與restaurants多對多關係)
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  #[使用者收藏很多餐廳]的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  #[使用者按讚很多餐廳]的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant
  
  #將PhotoUploader掛載上去，mount_uploader是carrierwave提供得掛載方法
  mount_uploader :avatar, PhotoUploader

  # 「使用者追蹤使用者」的 self-referential relationships 設定
  # 不需要另加 source，Rails 可從 Followship Model 設定來判斷 followings 指向 User Model
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships 


  # 「追蹤使用者的人」的設定
  # 透過 class_name, foreign_key 的自訂，指向 Followship 表上的另一側
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  # 「使用者的好友」的設定
  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where(friendships: {status: "accepted"})}, through: :friendships, dependent: :destroy
  has_many :applys, -> { where(friendships: {status: "applying"})}, through: :friendships, source: :friend

  #「把使用者加入好友的其他人」的設定
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :be_friends, -> { where(friendships: {status: "accepted"})}, through: :inverse_friendships, source: :user, dependent: :destroy
  has_many :apply_friends, -> { where(friendships: {status: "applying"})}, through: :inverse_friendships, source: :user


  def admin?
    self.role == "admin"
  end

  def is_like?(restaurant)
    self.liked_restaurants.include?(restaurant)
  end

  def following?(user)
    self.followings.include?(user)
  end

  def friend?(user)
    self.friends.include?(user) || self.be_friends.include?(user)
  end

  def applying?(user)
    self.applys.include?(user)
  end

  def accepted?(user)
    self.apply_friends.include?(user)
  end

  def all_friends
    self.friends + self.be_friends
  end
  
end

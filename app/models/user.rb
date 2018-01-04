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


  def admin?
    self.role == "admin"
  end

  def is_like?(restaurant)
    self.liked_restaurants.include?(restaurant)
  end
  
end

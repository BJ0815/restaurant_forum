class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader

  #[分類]的關聯設定
  belongs_to :category

  #[評論餐廳]的關聯設定：當 Restaurant 物件被刪除時,一併刪除依賴的 Comment
  has_many :comments, dependent: :destroy

  #[收藏餐廳]的關聯設定
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  #[按讚餐廳]的關聯設定
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def count_favorite
    self.restaurant_count = self.favorites.size
    self.save
  end

end

class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader

  #關聯設定
  belongs_to :category
  #當 Restaurant 物件被刪除時,一併刪除依賴的 Comment
  has_many :comments, dependent: :destroy

end

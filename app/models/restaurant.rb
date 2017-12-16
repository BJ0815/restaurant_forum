class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader

  #關聯設定
  belongs_to :category
  has_many :comments

end

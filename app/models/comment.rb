class Comment < ApplicationRecord

  #關聯設定
  belongs_to :user 
  belongs_to :restaurant
end

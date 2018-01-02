class Category < ApplicationRecord
  #驗證
  validates_presence_of :name
  
  #關聯設定(如果該分類下已有餐廳資訊，則不予許刪除該分類(刪除時會拋出 Error))
  has_many :restaurants, dependent: :restrict_with_error
end

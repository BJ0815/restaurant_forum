class Category < ApplicationRecord
  #關聯設定
  has_many :restaurants, dependent: :destroy
end

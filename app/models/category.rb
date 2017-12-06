class Category < ApplicationRecord
  validates_presence_of :name
  #關聯設定
  has_many :restaurants, dependent: :destroy
end

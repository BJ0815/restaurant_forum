class User < ApplicationRecord
  #驗證
  validates_presence_of :name, :email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #關聯設定(與comments一對多關係及與restaurants多對多關係)
  has_many :comments
  has_many :restaurants, through: :comments

  #將PhotoUploader掛載上去，mount_uploader是carrierwave提供得掛載方法
  mount_uploader :avatar, PhotoUploader


  def admin?
    self.role == "admin"
  end
  
end

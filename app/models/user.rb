class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :reservations, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :facilities, dependent: :destroy
  
  has_one_attached :icon_image # ActiveStorage利用
end

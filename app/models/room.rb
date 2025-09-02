class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  has_one_attached :image #Activestorageで施設画像を管理

  validates :name, :detail, :price, :address, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end

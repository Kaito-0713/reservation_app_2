class Facility < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true
  validates :description, presence: true, length: { maximum: 500 }
end

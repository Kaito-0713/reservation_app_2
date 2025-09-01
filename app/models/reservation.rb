class Reservation < ApplicationRecord 
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, :number_of_people, presence: true
  validates :number_of_people, numericality: { greater_than_or_equal_to: 1 }
  validate :check_dates

  # 合計金額を計算するメソッド
  def total_price
    return 0 unless start_date.present? && end_date.present? && room.present?

    nights = (end_date.to_date - start_date.to_date).to_i
    room.price.to_i * nights * number_of_people.to_i
  end

  private

  def check_dates
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "は今日以降の日付にしてください")
    end
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "は開始日より後の日付にしてください")
    end
  end
end

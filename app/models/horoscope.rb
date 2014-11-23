class Horoscope < ActiveRecord::Base
  belongs_to :zodiac

  validates :forecast, :date, :zodiac_id, presence: true
end

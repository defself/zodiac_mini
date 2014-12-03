class Horoscope < ActiveRecord::Base
  belongs_to :zodiac

  validates :forecast, :date, :zodiac_id, presence: true

  class << self
    def yesterday
      find_by date: Date.current - 1
    end

    def today
      find_by date: Date.current
    end

    def tomorrow
      find_by date: Date.current + 1
    end
  end
end

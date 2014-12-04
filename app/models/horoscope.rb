class Horoscope < ActiveRecord::Base
  belongs_to :zodiac

  validates :forecast, :date, :zodiac_id, presence: true

  SOURCE = "http://www.horoscopedates.com/archive"

  class << self
    def yesterday zodiac_id
      find_or_new(Date.current - 1, zodiac_id)
    end

    def today zodiac_id
      find_or_new(Date.current, zodiac_id)
    end

    def tomorrow zodiac_id
      find_or_new(Date.current + 1, zodiac_id)
    end

    private

    def find_or_new(date, zodiac_id)
      horoscope = Horoscope.find_by(date: date, zodiac_id: zodiac_id)
      return horoscope if horoscope

      require 'nokogiri'

      zodiac   = Zodiac.find_by id: zodiac_id
      page     = Nokogiri::HTML(open "#{SOURCE}/#{zodiac.sign}/?date=#{date}")
      forecast = page.css(".span8 p:nth-child(even)").text

      self.create forecast: forecast,
                  date:     date,
                  zodiac:   zodiac
    end
  end
end

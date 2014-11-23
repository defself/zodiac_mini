class Zodiac < ActiveRecord::Base
  has_many :users
  has_many :horoscopes

  validates :sign, :date, presence: true

  enum sign: %w(aquarius pisces aries taurus gemini cancer leo virgo libra scorpio sagittarius capricorn)
end

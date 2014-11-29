class Horoscope < ActiveRecord::Base
  belongs_to :zodiac

  validates :forecast, :date, :zodiac_id, presence: true

  scope :yesterday, -> { find_by date: Date.current - 1 }
  scope :today,     -> { find_by date: Date.current }
  #scope :tomorrow,  -> { find_by date: Date.current + 1 } TODO

  def self.tomorrow
    find_by date: Date.current + 1
  end
end

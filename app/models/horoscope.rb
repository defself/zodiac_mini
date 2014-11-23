class Horoscope < ActiveRecord::Base
  belongs_to :user

  validates :forecast, :date, presence: true
end

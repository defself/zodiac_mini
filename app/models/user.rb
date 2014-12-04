class User < ActiveRecord::Base
  has_one :session
  belongs_to :zodiac
  has_many :horoscopes, through: :zodiac

  validates :email, :password, :birthday, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true

  before_create :set_zodiac

  private

  def set_zodiac
    self.zodiac = Zodiac.where("date @> ?::date", birthday_of_this_year).first
  end

  def birthday_of_this_year
    birthday = self.birthday + (Date.current.year - self.birthday.year).years
    birthday += 1.year if birthday < Date.new(birthday.year, 1, 20)
    birthday
  end
end

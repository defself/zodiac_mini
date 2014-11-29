class User < ActiveRecord::Base
  has_one :session
  belongs_to :zodiac
  has_many :horoscopes, through: :zodiac

  validates :email, :password, :birthday, presence: true
  validates :password, confirmation: true

  before_validation :set_zodiac

  def set_zodiac
    self.zodiac = Zodiac.last # TODO
  end

  private

  #def birthday_of_this_year
  #  self.birthday + (Date.current.year - self.birthday.year).years
  #end
end

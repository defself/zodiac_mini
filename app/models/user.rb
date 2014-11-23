class User < ActiveRecord::Base
  has_many :horoscopes
  has_one :session

  validates :email, :password, :birthday, presence: true
  validates :password, confirmation: true
end

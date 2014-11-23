class User < ActiveRecord::Base
  has_one :session
  belongs_to :zodiac

  validates :email, :password, :birthday, :zodiac_id, presence: true
  validates :password, confirmation: true
end

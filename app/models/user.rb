class User < ActiveRecord::Base
  validates :email, :password, :birthday, presence: true
  validates :password, confirmation: true
end

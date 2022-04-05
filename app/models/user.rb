class User < ApplicationRecord
  has_secure_password
  has_many :slots
  # has_one_attached :avatar
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'Must be a valid email address' }
end

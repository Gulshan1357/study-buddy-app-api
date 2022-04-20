class User < ApplicationRecord
  has_secure_password
  has_many :slots
  has_many :first_user_meetings, class_name: 'Meeting', foreign_key: 'first_user_id'
  has_many :second_user_meetings, class_name: 'Meeting', foreign_key: 'second_user_id'
  has_many :api_keys, as: :bearer

  has_one_attached :avatar, :dependent => :destroy
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'Must be a valid email address' }
end

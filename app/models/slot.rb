class Slot < ApplicationRecord
  belongs_to :user
  validates :start_time, uniqueness: true
end

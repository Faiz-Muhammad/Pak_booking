class Booking < ApplicationRecord
  belongs_to :hotel

  has_many :room_bookings
  has_many :rooms, through: :room_bookings
end

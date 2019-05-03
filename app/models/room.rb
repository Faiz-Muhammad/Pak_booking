class Room < ApplicationRecord
  belongs_to :hotel

  has_many :room_bookings
  has_many :bookings, through: :room_bookings
end

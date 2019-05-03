class Hotel < ApplicationRecord
  has_many :rooms
  has_many :bookings

  accepts_nested_attributes_for :rooms, allow_destroy: true, reject_if: :all_blank
  attr_accessor :check_in, :check_out
end

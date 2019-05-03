module Api
  module V1
    class BookingsController < ApplicationController
      before_action :set_booking, only: [:update, :show, :destroy]
      before_action :set_hotel, only: [:index, :create, :available_rooms]

      def index
        @bookings = @hotel.bookings.all
        render json: @bookings
      end

      def create
        @booking = @hotel.bookings.build(booking_params)

        if @booking.save!
          render json: @booking, status: :created
        else
          render json: @booking.errors, status: :unprocessable_entity
        end
      end

      def update
        if @booking.update(booking_params)

          render json: @booking, status: :updated
        else
          render json: @booking.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @booking
      end

      def destroy
        @booking.destroy
      end

      def available_rooms
        range_date = []

        (booking_params[:check_in_date]..booking_params[:check_out_date]).select { |d|  range_date << d }
        r_ids = @hotel.rooms.includes(:bookings)
        .where({bookings: {check_in_date: range_date}} && {bookings: {check_out_date: range_date}})

        @available_rooms = @hotel.rooms.where.not(id: r_ids)

        render json: @available_rooms
      end

      private
        def booking_params
          params.require(:booking).permit(:number_of_users, :check_in_date, :check_out_date, :hotel_id, room_ids: [])
        end

        def set_booking
          @booking = Booking.find_by(id: params[:id])
        end

        def set_hotel
          @hotel = Hotel.find_by(id: params[:booking][:hotel_id])
        end
    end
  end
end

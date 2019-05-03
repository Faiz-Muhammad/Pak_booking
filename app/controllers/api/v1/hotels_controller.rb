module Api
  module V1
    class HotelsController < ApplicationController
      before_action :set_hotel, only: [:update, :show, :destroy, :available_rooms]

      def index
        @hotels = Hotel.all

        render json: @hotels
      end

      def create
        @hotel = Hotel.new(hotel_params)

        if @hotel.save!
          render json: @hotel, status: :created
        else
          render json: @hotel.errors, status: :unprocessable_entity
        end
      end

      def update
        if @hotel.update!(hotel_params)

          render json: @hotel, status: :updated
        else
          render json: @hotel.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @hotel
      end

      def destroy
        @hotel.destroy!
      end

      def available_rooms
        range_date = []
        (Booking.first.check_in_date..Booking.first.check_out_date).select { |d|  range_date << d }
      end

      private
        def available_room_params
          params.require(:hotel).permit(:check_in, :check_out)
        end

        def hotel_params
          params.require(:hotel).permit(:name, :location, :city, :rating,
             rooms_attributes: [:id, :price, :room_number, :room_type, :booked_status])
        end

        def set_hotel
          @hotel = Hotel.find_by(id: params[:id])
        end
    end
  end
end

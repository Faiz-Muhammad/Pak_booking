module Api
  module V1
    class RoomsController < ApplicationController
      before_action :set_room, only: [:show, :destroy]
      before_action :set_hotel, only: [:index]

      def index
        @rooms = @hotel.rooms.all
        render json: @rooms
      end

      def show
        render json: @room
      end

      def destroy
        @room.destroy
      end

      private
        def set_room
          @room = Room.find_by(id: params[:id])
        end

        def set_hotel
          @hotel = Hotel.find_by(id: params[:hotel_id])
        end
    end
  end
end

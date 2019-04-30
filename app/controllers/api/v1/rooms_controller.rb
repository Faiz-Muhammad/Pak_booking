module Api
  module V1
    class RoomsController < ApplicationController
      before_action :set_room, only: [:edit, :update, :show, :destroy]
      before_action :set_hotel

      def index
        @rooms = @hotel.rooms.all
        render json: @rooms
      end

      def create
        @room = @hotel.rooms.build(room_params)

        if @room.save
          render json: @room, status: :created, location: @room
        else
          render json: @room.errors, status: :unprocessable_entity
        end
      end

      def update
        if @room.update(room_params)
          render json: @room, status: :updated, location: @room
        else
          render json: @room.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @room
      end

      def destroy
        @room.destroy
      end

      private
        def room_params
          params.require(:room).permit(:price, :room_number, :room_type, :booked_status, :hotel_id)
        end

        def set_room
          @room = Room.find_by(id: params[:id])
        end

        def set_hotel
          @hotel = Hotel.find_by(id: params[:id])
        end
    end
  end
end

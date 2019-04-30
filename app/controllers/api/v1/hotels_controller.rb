module Api
  module V1
    class HotelsController < ApplicationController
      before_action :set_hotel, only: [:edit, :update, :show, :destroy]

      def index
        @hotels = Hotel.all

        render json: @hotels
      end

      def create
        @hotel = Hotel.build(hotel_params)

        if @hotel.save
          render json: @hotel, status: :created, location: @hotel
        else
          render json: @hotel.errors, status: :unprocessable_entity
        end
      end

      def update
        if @hotel.update(hotel_params)
          render json: @hotel, status: :updated, location: @hotel
        else
          render json: @hotel.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @hotel
      end

      def destroy
        @hotel.destroy
      end

      private
        def hotel_params
          params.rquire(:hotel).permit(:name, :location, :city, :rating)
        end

        def set_hotel
          @hotel = Hotel.find_by(id: params[:id])
        end
    end
  end
end

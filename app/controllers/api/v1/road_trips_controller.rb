class Api::V1::RoadTripsController < ApplicationController
    before_action :authenticate_api_key
    def create
        if (trip_params[:origin].present? && trip_params[:destination].present?)
            road_trip = RoadTrip.new(trip_params)
            render json: RoadTripSerializer.new(road_trip)
        else
            error = Error.new("Missing required query parameter")
            render json: ErrorSerializer.new(error), status: 400
        end
    end

    private

    def trip_params
        params.require(:road_trip).permit(:origin, :destination, :api_key)
    end

end
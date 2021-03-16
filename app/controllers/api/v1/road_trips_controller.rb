class Api::V1::RoadTripsController < ApplicationController
    before_action :authenticate_api_key
    def create
        trip_data = get_trip_data(trip_params[:origin], trip_params[:destination])
        render json: RoadTripSerializer.new(RoadTrip.new(trip_data))
    end

    private

    def trip_params
        params.require(:road_trip).permit(:origin, :destination, :api_key)
    end

    def get_trip_data(origin, destination)
        trip_data = MapQuestService.new.get_trip_data(origin, destination)
        dest_coords = MapQuestService.new.get_coordinates(destination)
        end_weather = OpenWeatherService.new.get_weather_by_coordinates(dest_coords)
        get_weather_at_eta(end_weather, trip_data)
    end

    def get_weather_at_eta(destination, trip_data)
        require 'pry'; binding.pry  
    end

    def destination_weather(destination)    
end
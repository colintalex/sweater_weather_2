class Api::V1::RoadTripsController < ApplicationController
    before_action :authenticate_api_key

    def create
        trip = RoadTrip.new(full_trip_data[:geo], full_trip_data[:weather])
        render json: RoadTripSerializer.new(trip)
    end

    private

    def trip_params
        params.require(:road_trip).permit(:origin, :destination)
    end

    def api_params
        params.require(:road_trip).permit(:api_key)
    end

    def get_geo_data(origin, destination)
        MapQuestService.new.get_travel_data(origin, destination)
    end

    def get_eta_weather_data(destination, eta)
        OpenWeatherService.new.weather_at_time_and_location(destination, eta)
    end

    def full_trip_data
        geo_data = get_geo_data(trip_params[:origin], trip_params[:destination])
        weather_data = get_eta_weather_data(trip_geo_data[:destination], trip_geo_data[:eta])
        { geo: geo_data, weather: weather_data }
    end
end
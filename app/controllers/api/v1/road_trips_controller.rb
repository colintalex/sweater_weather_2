class Api::V1::RoadTripsController < ApplicationController
    before_action :authenticate_api_key

    def create
        trip_data = {}
        trip_data[:travel] = full_trip_data[:travel]
        trip_data[:weather] = full_trip_data[:weather]
        trip = RoadTrip.new(trip_data[:travel], trip_data[:weather], trip_params)
        render json: RoadTripSerializer.new(trip)
    end

    private

    def trip_params
        params.require(:road_trip).permit(:origin, :destination)
    end

    def api_params
        params.require(:road_trip).permit(:api_key)
    end

    def get_travel_data(origin, destination)
        travel_time = MapQuestService.new.request_travel_data(origin, destination)
        dest_coords = MapQuestService.new.get_coordinates(destination)
        trip_duration = travel_time[:travel_time][:formattedTime]
        { destination: dest_coords, eta: trip_duration }
    end

    def get_eta_weather_data(destination, eta)
        hourly_weather = OpenWeatherService.new.get_weather_by_coordinates(destination)[:hourly]
        now = Time.now
        arrival = now + Time.parse(eta).seconds_since_midnight
        arrival.min > 25 ? index = arrival.hour : index = arrival.hour - 1
        hourly_weather[4]
    end

    def full_trip_data
        travel_data = get_travel_data(trip_params[:origin], trip_params[:destination])
        weather_data = get_eta_weather_data(travel_data[:destination], travel_data[:eta])
        { travel: travel_data, weather: weather_data }
    end
end
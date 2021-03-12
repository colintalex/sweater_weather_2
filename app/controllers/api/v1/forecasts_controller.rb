class Api::V1::ForecastsController < ApplicationController

    def show
        coords = get_location_coordinates(forecast_params[:location])
        weather = get_weather_by_coordinates(coords)
        render json: CityWeatherSerializer.new(weather)
    end

    private

    def forecast_params
        params.permit(:location)
    end
    
    def get_location_coordinates(location)
        MapQuestService.new.get_coordinates(location)
    end

    def get_weather_by_coordinates(coords)
        resp = OpenWeatherService.new.get_weather_by_coordinates(coords)
        CityWeather.new(resp)
    end
end
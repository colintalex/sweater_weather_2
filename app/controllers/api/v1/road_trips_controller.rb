class Api::V1::RoadTripsController < ApplicationController
    before_action :authenticate_api_key

    def create
        require 'pry'; binding.pry
        # gather map data // Mapquest
        # gather weather data for eta at destination // open weather,  
        # pass data into roadtrip object (poro, no db)
        
        #gather data for roadrisk // openweather // future
            # pass data into relational poro for road_risk // future
        # serialize roadtrip poro
    end

    private

    def trip_params
        params.require(:road_trip).permit(:origin, :destination, :api_key)
    end


end
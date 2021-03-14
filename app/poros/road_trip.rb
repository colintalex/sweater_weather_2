class RoadTrip
    attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta
    def initialize(travel_data, eta_weather_data, trip_params)
        @start_city = trip_params[:origin]
        @end_city = trip_params[:destination]
        @travel_time = travel_data[:eta]
        @weather_at_eta = eta_weather_data
    end
end
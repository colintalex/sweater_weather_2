class RoadTrip
    attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

    def initialize(trip_data)
        require 'pry'; binding.pry
        @start_city = ''    
        @end_city = ''    
        @travel_time = ''    
        @weather_at_eta = ''    
    end
end
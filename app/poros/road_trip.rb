class RoadTrip
    attr_reader :start_city, :end_city, :travel_time, :weather_at_eta
    def initialize(trip_data)
        @start_city = trip_data[:origin]
        @end_city = trip_data[:destination]
        @travel_time = get_travel_time(@start_city, @end_city)
        @weather_at_eta = get_weather_at_eta(@end_city)
    end

    def get_travel_time(origin, destination)
        trip_data = MapQuestService.new.get_trip_data(origin, destination)
        trip_data[:route][:formattedTime].present? ? trip_data[:route][:formattedTime] : nil
    end

    def get_weather_at_eta(destination)
        return if @travel_time == nil
        end_weather = get_weather_at_destination(destination)
        eta_weather = end_weather[:hourly][hourly_weather_index].slice(:temp, :weather)
        eta_weather[:temperature] = eta_weather.delete(:temp)
        eta_weather[:conditions] = eta_weather.delete(:weather)[0][:description]
        eta_weather
    end

    def get_weather_at_destination(destination)
        dest_coords = MapQuestService.new.get_coordinates(destination)
        OpenWeatherService.new.get_weather_by_coordinates(dest_coords)
    end

    def hourly_weather_index
        trip_in_secs = Time.parse(@travel_time).seconds_since_midnight
        rounded_hour = ((trip_in_secs /60 ) / 60).round
        arrival_time = Time.now + trip_in_secs
        if (arrival_time.strftime("%M").to_i >= 35)
            rounded_hour += 1
        end
        rounded_hour
    end

    def route_error
        error = Error.new("The route for given destination is not valid")
        render json: ErrorSerializer.new(error), status: 401
    end
end
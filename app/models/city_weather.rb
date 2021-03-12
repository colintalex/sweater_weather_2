require 'date'
class CityWeather
    attr_reader :id, :current_weather, :daily_weather, :hourly_weather
    def initialize(resp)
        @current_weather = convert_current_times(resp[:current])
        @hourly_weather = convert_hourly_times(resp[:hourly])
        @daily_weather = convert_daily_times(resp[:daily])
    end

    def convert_current_times(data)
        data[:dt] = Time.at(data[:dt])
        data[:sunrise] = Time.at(data[:sunrise])
        data[:sunset] = Time.at(data[:sunset])
        data
    end

    def convert_hourly_times(data)
        data.each do |hour|
            hour[:dt] = Time.at(hour[:dt]).strftime("%k:%M:%S")
        end
        data
    end

    def convert_daily_times(data)
        data.each do |day|
            day[:dt] = Time.at(day[:dt]).strftime("%m/%d/%y")
            day[:sunrise] = Time.at(day[:sunrise])
            day[:sunset] = Time.at(day[:sunset])
        end
    end
end
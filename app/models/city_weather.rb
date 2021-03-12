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
        data[:datetime] = data.delete(:dt)
        data[:temperature] = data.delete(:temp)
        data[:conditions] = data.delete(:weather)
        data[:icon] = data[:conditions][0][:icon]
        data[:conditions] = data[:conditions][0][:description].capitalize
        data[:sunrise] = Time.at(data[:sunrise])
        data[:sunset] = Time.at(data[:sunset])
        data.slice(:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon)
    end

    def convert_hourly_times(data)
        data.each do |hour|
            hour[:dt] = Time.at(hour[:dt]).strftime("%k:%M:%S")
            hour[:time] = hour.delete(:dt)
            hour[:temperature] = hour.delete(:temp)
            hour[:conditions] = hour.delete(:weather)
            hour[:icon] = hour[:conditions][0][:icon]
            hour[:conditions] = hour[:conditions][0][:description].capitalize
            hour.slice!(:time, :temperature, :conditions, :icon)
        end
    end

    def convert_daily_times(data)
        data.each do |day|
            day[:dt] = Time.at(day[:dt]).strftime("%m/%d/%y")
            day[:date] = day.delete(:dt)
            day[:conditions] = day.delete(:weather)
            day[:icon] = day[:conditions][0][:icon]
            day[:conditions] = day[:conditions][0][:description].capitalize
            day[:sunrise] = Time.at(day[:sunrise])
            day[:sunset] = Time.at(day[:sunset])

            day[:max_temp] = day[:temp][:max]
            day[:min_temp] = day[:temp][:min]
            day.slice!(:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon)
        end
    end
end
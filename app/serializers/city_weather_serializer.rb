class CityWeatherSerializer
    include JSONAPI::Serializer
    set_type :forecast  # optional
    attributes :current_weather, :hourly_weather, :daily_weather
end
class RoadTripSerializer
    include JSONAPI::Serializer
    set_type :roadtrip
    attributes :start_city, :end_city, :travel_time

    attribute :weather_at_eta do |obj|
        {
            temperature: obj.weather_at_eta[:temp],
            conditions: obj.weather_at_eta[:weather][0][:description].capitalize
        }
    end
end
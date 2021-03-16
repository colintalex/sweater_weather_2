class MapQuestService
    def conn
        Faraday.new(
            url: 'http://www.mapquestapi.com/',
            params: {key: Rails.application.credentials.map_quest_api_key},
            headers: {'Content-Type' => 'application/json'}
        )
    end

    def get_coordinates(location)
        resp = conn.post("geocoding/v1/address?location=#{location}")
        json = JSON.parse(resp.body, symbolize_names: true)
        json[:results][0][:locations][0][:latLng]
    end

    def get_trip_data(origin, destination)
        resp  = conn.post("directions/v2/route") do |req|
            req.params['from'] = origin
            req.params['to'] = destination
        end
        json = JSON.parse(resp.body, symbolize_names: true)
    end
end
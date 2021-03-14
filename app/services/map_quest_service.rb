class MapQuestService
    def conn
        Faraday.new(
            url: 'http://www.mapquestapi.com',
            params: {key: Rails.application.credentials.map_quest_api_key},
            headers: {'Content-Type' => 'application/json'}
        )
    end

    def get_coordinates(location)
        resp = conn.post("/geocoding/v1/address?location=#{location}")
        json = JSON.parse(resp.body, symbolize_names: true)
        json[:results][0][:locations][0][:latLng]
    end

    def request_travel_data(origin, destination)
        #get travel time, eta, and coords for each location directions/v2/route
        resp = conn.get("directions/v2/route", { from: origin, to: destination })
        json = JSON.parse(resp.body, symbolize_names: true)
        {
            travel_time: json[:route]
        }
    end
end
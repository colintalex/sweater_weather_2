class MapQuestService
    def conn
        Faraday.new(
            url: 'http://www.mapquestapi.com/geocoding/v1/',
            params: {key: Rails.application.credentials.map_quest_api_key},
            headers: {'Content-Type' => 'application/json'}
        )
    end

    def get_coordinates(location)
        resp = conn.post("address?location=#{location}")
        json = JSON.parse(resp.body, symbolize_names: true)
        json[:results][0][:locations][0][:latLng]
    end
end
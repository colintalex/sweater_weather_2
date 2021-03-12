class OpenWeatherService
    def conn
        Faraday.new(
            url: 'https://api.openweathermap.org/data/2.5/',
            params: { appId: Rails.application.credentials.open_weather_api_key }
        )
    end

    def get_weather_by_coordinates(coords)
        resp = conn.post('onecall') do |req|
            req.params['lat'] = coords[:lat]
            req.params['lon'] = coords[:lng]
            req.params['exclude'] = 'minutely'
            req.params['units'] = 'imperial'
        end
        json = JSON.parse(resp.body, symbolize_names: true)
    end
end
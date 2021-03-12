class BackgroundImageService

    def conn
        Faraday.new(
            url: 'https://api.unsplash.com/',
            headers: { Authorization: "Client-ID " + Rails.application.credentials.unsplash_access_key}
        )
    end

    def get_image(location)
        resp = conn.get('search/photos') do |req|
            req.params['query'] = location
        end
        json = JSON.parse(resp.body, symbolize_names: true)[:results][0]
    end
end
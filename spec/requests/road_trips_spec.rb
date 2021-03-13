require 'rails_helper'

RSpec.describe "RoadTrips", type: :request do
  describe "GET /road_trips" do
    it "works! (now write some real specs)" do
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "RUNJjbtr8nfe5RYTnA9ApeoV"
      }

      post '/api/v1/road_trip', params: { road_trip: body }
      
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to have_key(:id)
      expect(body[:data][:id]).to eql('null')
      expect(body[:data]).to have_key(:type)
      expect(body[:data][:type]).to eql('roadtrip')
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:start_city)
      expect(body[:data][:attributes]).to have_key(:end_city)
      expect(body[:data][:attributes]).to have_key(:travel_time)
      expect(body[:data][:attributes]).to have_key(:weather_at_eta)
      expect(body[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(body[:data][:attributes][:weather_at_eta][:temperature]).to type_of(float)
      expect(body[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    end
  end
end

require 'rails_helper'

RSpec.describe "RoadTrips", type: :request do
  describe "GET /road_trips" do
    before(:each) do 
      @user = User.create({
        email: 'c@g.com',
        password: 'password',
        password_confirmation: 'password'
      })
    end
    it "works! (now write some real specs)" do
      
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": @user.api_key
      }

      post '/api/v1/road_trip', params: { road_trip: body }
      
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)

      expect(body[:data]).to have_key(:id)
      expect(body[:data][:id]).to eql(nil)
      expect(body[:data]).to have_key(:type)
      expect(body[:data][:type]).to eql('roadtrip')
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:start_city)
      expect(body[:data][:attributes]).to have_key(:end_city)
      expect(body[:data][:attributes]).to have_key(:travel_time)
      expect(body[:data][:attributes]).to have_key(:weather_at_eta)
      expect(body[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(body[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    end

    it "doesn't work with bad api key" do
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "supahkey"
      }

      post '/api/v1/road_trip', params: { road_trip: body }
      
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(400)
    end
  end
end

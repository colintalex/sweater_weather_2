require 'rails_helper'

RSpec.describe "RoadTrips", type: :request do
  before(:each) do
    @user = User.create(
      email: "test", 
      password: "pass", 
      password_confirmation: "pass"
    )
  end
  describe "Green Path Tests" do
    it "works with a valid request" do
      params = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": @user.api_key
      }
      post "/api/v1/roadtrip", params: params

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to have_key(:id)
      expect(body[:data][:id]).to eql("null")
      expect(body[:data]).to have_key(:type)
      expect(body[:data][:type]).to eql("roadtrip")
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:start_city)
      expect(body[:data][:attributes][:start_city]).to eql(params[:origin])
      expect(body[:data][:attributes]).to have_key(:end_city)
      expect(body[:data][:attributes][:end_city]).to eql(params[:destination])
      expect(body[:data][:attributes]).to have_key(:travel_time)
      expect(body[:data][:attributes]).to have_key(:weather_at_eta)
      expect(body[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(body[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    end
  end

  describe "Edge tests" do
    it "should omit weather_at_eta if impossible travel times " do
      params = {
        "origin": "Denver,CO",
        "destination": "Beijing",
        "api_key": @user.api_key
      }
      post "/api/v1/roadtrip", params: params

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(body[:data]).to have_key(:id)
      expect(body[:data][:id]).to eql("null")
      expect(body[:data]).to have_key(:type)
      expect(body[:data][:type]).to eql("roadtrip")
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:start_city)
      expect(body[:data][:attributes][:start_city]).to eql(params[:origin])
      expect(body[:data][:attributes]).to have_key(:end_city)
      expect(body[:data][:attributes][:end_city]).to eql(params[:destination])
      expect(body[:data][:attributes]).to have_key(:travel_time)
      expect(body[:data][:attributes]).to_not have_key(:weather_at_eta)
    end
  end

  describe "Missing query param =>" do
    it "Origin error" do
      params = {
        "origin": "",
        "destination": "Beijing",
        "api_key": @user.api_key
      }
      post "/api/v1/roadtrip", params: params

      expect(response).to have_http_status(400)
      body = JSON.parse(response.body, symbolize_names: true)
    end
    
    it "Destination error" do
      params = {
        "origin": "Denver,CO",
        "destination": "",
        "api_key": @user.api_key
      }
      post "/api/v1/roadtrip", params: params

      expect(response).to have_http_status(400)
      body = JSON.parse(response.body, symbolize_names: true)
    end
  end

  describe "API key" do
    it "returns an error with invalid key" do
      params = {
        "origin": "Denver,CO",
        "destination": "Santa Fe, NM",
        "api_key": "wrongapikey12345"
      }
      post "/api/v1/roadtrip", params: params

      expect(response).to have_http_status(400)
      body = JSON.parse(response.body, symbolize_names: true)
    end
  end
end

require 'rails_helper'

RSpec.describe "ForecastByCities", type: :request do
  describe "GET /api/v1/forecast?location=" do
    it "returns success with valid city" do
      city = 'Denver'
      get "/api/v1/forecast?location=Denver"

      expect(response).to have_http_status(200)
      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to have_key(:current_weather)
      expect(data[:attributes]).to have_key(:hourly_weather)
      expect(data[:attributes]).to have_key(:daily_weather)
    end
  end
end

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
        expect(data[:attributes][:current_weather]).to have_key(:datetime)
        expect(data[:attributes][:current_weather]).to have_key(:sunrise)
        expect(data[:attributes][:current_weather]).to have_key(:sunset)
        expect(data[:attributes][:current_weather]).to have_key(:temperature)
        expect(data[:attributes][:current_weather]).to have_key(:feels_like)
        expect(data[:attributes][:current_weather]).to have_key(:humidity)
        expect(data[:attributes][:current_weather]).to have_key(:uvi)
        expect(data[:attributes][:current_weather]).to have_key(:visibility)
        expect(data[:attributes][:current_weather]).to have_key(:conditions)
        expect(data[:attributes][:current_weather]).to have_key(:icon)
        expect(data[:attributes][:current_weather]).to_not have_key(:dt)
        expect(data[:attributes][:current_weather]).to_not have_key(:temp)
        expect(data[:attributes][:current_weather]).to_not have_key(:pressure)
        expect(data[:attributes][:current_weather]).to_not have_key(:dew_point)
        expect(data[:attributes][:current_weather]).to_not have_key(:clouds)
        expect(data[:attributes][:current_weather]).to_not have_key(:wind_speed)
        expect(data[:attributes][:current_weather]).to_not have_key(:wind_deg)
        expect(data[:attributes][:current_weather]).to_not have_key(:wind_gust)
        expect(data[:attributes][:current_weather]).to_not have_key(:weather)

      expect(data[:attributes]).to have_key(:daily_weather)
        expect(data[:attributes][:daily_weather][0]).to have_key(:date)
        expect(data[:attributes][:daily_weather][0]).to have_key(:sunrise)
        expect(data[:attributes][:daily_weather][0]).to have_key(:sunset)
        expect(data[:attributes][:daily_weather][0]).to have_key(:max_temp)
        expect(data[:attributes][:daily_weather][0]).to have_key(:min_temp)
        expect(data[:attributes][:daily_weather][0]).to have_key(:conditions)
        expect(data[:attributes][:daily_weather][0]).to have_key(:icon)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:dt)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:temp)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:feels_like)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:pressure)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:humidity)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:dew_point)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:uvi)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:clouds)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:rain)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:snow)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:visibility)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:wind_deg)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:wind_speed)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:wind_gust)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:weather)
        expect(data[:attributes][:daily_weather][0]).to_not have_key(:pop)
      expect(data[:attributes]).to have_key(:hourly_weather)
        expect(data[:attributes][:hourly_weather][0]).to have_key(:time)
        expect(data[:attributes][:hourly_weather][0]).to have_key(:temperature)
        expect(data[:attributes][:hourly_weather][0]).to have_key(:conditions)
        expect(data[:attributes][:hourly_weather][0]).to have_key(:icon)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:dt)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:temp)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:pressure)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:humidity)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:dew_point)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:uvi)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:clouds)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:visibility)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:wind_deg)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:wind_speed)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:wind_gust)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:weather)
        expect(data[:attributes][:hourly_weather][0]).to_not have_key(:pop)
    end

    it "returns error with empty query" do
      get "/api/v1/forecast?location="

      expect(response).to have_http_status(400)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:description]).to eql("Location can't be empty")
      expect(data).to_not have_key(:attributes)
      expect(data).to_not have_key(:id)
    end
  end
end

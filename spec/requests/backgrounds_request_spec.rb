require 'rails_helper'

RSpec.describe "Backgrounds", type: :request do
  describe "GET /backgrounds" do
    it "works! (now write some real specs)" do
      city = "Denver"

      get "/api/v1/backgrounds?location=#{city}"
      
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:image)
      expect(body[:data][:attributes][:image]).to have_key(:location)
      expect(body[:data][:attributes][:image]).to have_key(:image_url)
      expect(body[:data][:attributes][:image]).to have_key(:credit)
      expect(body[:data][:attributes][:image][:credit]).to have_key(:source)
      expect(body[:data][:attributes][:image][:credit]).to have_key(:logo)
      expect(body[:data][:attributes][:image][:credit]).to have_key(:author)
    end
  end
end

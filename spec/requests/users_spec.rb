require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      body = {
        email: 'c@g.com',
        password: 'password',
        password_confirmation: 'password'
      }
      post "/api/v1/users", params: { user: body }

      expect(response).to have_http_status(201)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
    end

    it "returns an error with mismatched passwords" do
      body = {
        email: 'c@g.com',
        password: 'passwoyd',
        password_confirmation: 'password'
      }
      post "/api/v1/users", params: { user: body }

      expect(response).to have_http_status(422)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:description)
      expect(body[:data][:attributes][:description]).to eql("Password confirmation doesn't match Password")
    end

    it "returns an error if user already exists" do
      user = User.create({
        email: 'c@g.com',
        password: 'password',
        password_confirmation: 'password'
      })

      body = {
        email: 'c@g.com',
        password: 'password',
        password_confirmation: 'password'
      }
      post "/api/v1/users", params: { user: body }

      expect(response).to have_http_status(422)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:description)
      expect(body[:data][:attributes][:description]).to eql("Email has already been taken")
      user.delete
    end

    it "returns an error with missing pw_confirm field" do
        body = {
        email: 'c@g.com',
        password: 'password',
        password_confirmation: ''
      }
      post "/api/v1/users", params: { user: body }

      expect(response).to have_http_status(422)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:description)
      expect(body[:data][:attributes][:description]).to eql("Password confirmation doesn't match Password")
    end

    it "returns an error with missing password field" do
        body = {
        email: 'c@g.com',
        password: '',
        password_confirmation: 'password'
      }
      post "/api/v1/users", params: { user: body }

      expect(response).to have_http_status(422)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:description)
      expect(body[:data][:attributes][:description]).to eql("Password can't be blank and Password confirmation doesn't match Password")
    end

    it "returns an error with missing email field" do
        body = {
        email: '',
        password: 'password',
        password_confirmation: 'password'
      }
      post "/api/v1/users", params: { user: body }

      expect(response).to have_http_status(422)
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:type)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to have_key(:description)
      expect(body[:data][:attributes][:description]).to eql("Email can't be blank")
    end
  end
end

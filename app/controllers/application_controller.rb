class ApplicationController < ActionController::API
   def authenticate_api_key
        @user = User.find_by(api_key: trip_params[:api_key])
        require 'pry'; binding.pry
        @user.nil? ? bad_api_key : return
    end

    def bad_api_key
        error = Error.new("The API key was not authenticated and is incorrect")
        render json: ErrorSerializer.new(error), status: 401
    end
end

class ApplicationController < ActionController::API

    private

    def authenticate_api_key
        user = User.find_by(api_key: trip_params['api_key'])
        user.nil? ? bad_api_key : return
    end

    def bad_api_key
        bad_key_error = Error.new('Unauthorized access. Sign up for API key, or check your current one')
        render json: ErrorSerializer.new(bad_key_error), status: 400
    end
end

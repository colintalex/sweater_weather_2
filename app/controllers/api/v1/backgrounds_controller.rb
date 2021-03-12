class Api::V1::BackgroundsController < ApplicationController

    def show
        image = get_image(image_params[:location])
        render json: BackgroundImageSerializer.new(image)
    end

    private

    def image_params
        params.permit(:location)
    end

    def get_image(location)
        image_data = BackgroundImageService.new.get_image(location)
        BackgroundImage.new(image_data)
    end
end
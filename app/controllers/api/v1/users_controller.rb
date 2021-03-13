class Api::V1::UsersController < ApplicationController
    wrap_parameters :user, include: [:email, :password, :password_confirmation]
    def create
        @user = User.new(user_params)
        if @user.save
            render json: UserSerializer.new(@user), status: :created
        else
            @error = Error.new(@user.errors.full_messages)
            render json: ErrorSerializer.new(@error), status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
module Api
  module V1
    class UsersController < ApplicationController
      protect_from_forgery with: :null_session
      
      def create
        @user = User.new(user_params)
        if @user.save
          render json: { message: 'User was successfully created!', user_id: @user.id }, status: :created
        else
          render json: { error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :email, :password)
      end
    end
  end
end

module Api
  module V1
    class SessionsController < ApplicationController
      protect_from_forgery with: :null_session
      
      def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          render json: { message: 'Logged in successfully!', user_id: user.id }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
        end
      end
    end
  end
end

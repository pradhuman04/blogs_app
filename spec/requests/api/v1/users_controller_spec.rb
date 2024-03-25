require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            username: 'testuser',
            email: 'test@example.com',
            password: 'password'
          }
        }
      end

      it 'creates a new user' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'returns the user id in the response' do
        post :create, params: valid_params
        expect(JSON.parse(response.body)['user_id']).to be_present
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            username: '',
            email: 'invalid_email',
            password: 'short'
          }
        }
      end

      it 'does not create a new user' do
        expect {
          post :create, params: invalid_params
        }.to_not change(User, :count)
      end

      it 'returns an unprocessable entity status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors in the JSON response' do
        post :create, params: invalid_params
        expect(JSON.parse(response.body)['error']).to be_present
      end
    end
  end
end

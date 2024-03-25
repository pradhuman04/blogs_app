require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'POST #create' do
    let!(:user) { create(:user, email: 'test@example.com', password: 'password') }

    context 'with valid credentials' do
      let(:valid_params) do
        {
          email: 'test@example.com',
          password: 'password'
        }
      end

      it 'returns a success response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user id in the response' do
        post :create, params: valid_params
        expect(JSON.parse(response.body)['user_id']).to eq(user.id)
      end

      it 'returns a success message in the response' do
        post :create, params: valid_params
        expect(JSON.parse(response.body)['message']).to eq('Logged in successfully!')
      end
    end

    context 'with invalid credentials' do
      let(:invalid_params) do
        {
          email: 'invalid@example.com',
          password: 'invalid_password'
        }
      end

      it 'returns an unprocessable entity status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message in the response' do
        post :create, params: invalid_params
        expect(JSON.parse(response.body)['error']).to eq('Invalid email or password')
      end
    end
  end
end

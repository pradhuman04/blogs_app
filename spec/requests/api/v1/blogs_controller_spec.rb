require 'rails_helper'

RSpec.describe Api::V1::BlogsController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let!(:blogs) { create_list(:blog, 10, user: user) }

    context 'when user is authenticated' do
      before do
        session[:user_id] = user.id
      end

      it 'returns a successful response' do
        get :index
        expect(response).to have_http_status(:success)
      end

    end

    context 'when user is not authenticated' do
      it 'returns an unauthorized response' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'when user is authenticated' do
      before do
        session[:user_id] = user.id
      end

      context 'with valid attributes' do
        it 'creates a new blog' do
          expect {
            post :create, params: { title: 'Test Title', content: 'Test Content' }
          }.to change(user.blogs, :count).by(1)
        end

        it 'returns a created status' do
          post :create, params: { title: 'Test Title', content: 'Test Content' }
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new blog' do
          expect {
            post :create, params: { title: '', content: '' }
          }.to_not change(Blog, :count)
        end

        it 'returns an unprocessable entity status' do
          post :create, params: { title: '', content: '' }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns errors in the JSON response' do
          post :create, params: { title: '', content: '' }
          expect(JSON.parse(response.body)['error']).to be_present
        end
      end
    end

    context 'when user is not authenticated' do
      it 'returns an unauthorized response' do
        post :create, params: { title: 'Test Title', content: 'Test Content' }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

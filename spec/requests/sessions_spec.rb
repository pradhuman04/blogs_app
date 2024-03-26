require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    context 'when user is not logged in' do
      it 'renders the new template' do
        allow(controller).to receive(:current_user).and_return(nil)
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when user is logged in' do
      it 'redirects to blogs path' do
        allow(controller).to receive(:current_user).and_return(double)
        get :new
        expect(response).to redirect_to(blogs_path)
      end
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user, email: 'test@example.com', password: 'password') }

    context 'with valid credentials' do
      it 'logs in the user' do
        post :create, params: { email: 'test@example.com', password: 'password' }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(blogs_path)
        expect(flash[:notice]).to eq('Logged in successfully!')
      end
    end

    context 'with invalid credentials' do
      it 'does not log in the user' do
        post :create, params: { email: 'invalid@example.com', password: 'invalid_password' }
        expect(session[:user_id]).to be_nil
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq('Invalid email or password')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs out the user' do
      session[:user_id] = 1 # Assuming a user is logged in
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path)
      expect(flash[:notice]).to eq('Logged out successfully!')
    end
  end
end

# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    context 'when user is not logged in' do
      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns a new user' do
        get :new
        expect(assigns(:user)).to be_a_new(User)
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
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'logs in the new user' do
        post :create, params: { user: attributes_for(:user) }
        expect(session[:user_id]).to eq(User.last.id)
      end

      it 'redirects to blogs path' do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(blogs_path)
      end

      it 'sets flash notice message' do
        post :create, params: { user: attributes_for(:user) }
        expect(flash[:notice]).to eq('User was successfully created!')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: { username: '', email: '', password: '', password_confirmation: '' } }
        }.to_not change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: { user: { username: '', email: '', password: '', password_confirmation: '' } }
        expect(response).to render_template(:new)
      end
    end

    context 'when password confirmation does not match password' do
      it 'renders the new template' do
        post :create, params: { user: { username: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'different_password' } }
        expect(response).to render_template(:new)
      end
    end
  end
end

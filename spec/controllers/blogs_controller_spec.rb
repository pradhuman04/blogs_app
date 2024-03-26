require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  describe 'GET #index' do
    context 'when user is logged in' do
      let(:user) { create(:user) }
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'assigns @blogs' do
        blogs = create_list(:blog, 5, user: user)
        get :index
        expect(assigns(:blogs)).to match_array(blogs)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login path' do
        get :index
        expect(response).to redirect_to(login_path)
      end

      it 'sets flash alert message' do
        get :index
        expect(flash[:alert]).to eq('You must be logged in to access this section')
      end
    end
  end
end

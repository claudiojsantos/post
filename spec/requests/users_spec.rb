require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    context 'verify authorization' do
      let(:url) { "#{base_url}/users" }

      it 'return 401 status if user is not logged in' do
        get url
        expect(response).to custom_have_http_status(401)
      end
    end

    context 'with no pagination params' do
      let(:url) { "#{base_url}/users" }
      let(:current_user) { create(:user) }
      let!(:users) { create_list(:user, 20) }

      it 'returns the first page of users' do
        get url, headers: login_as(current_user)
        expect(response).to custom_have_http_status(200)
      end
    end

    context 'with pagination params exceeding total pages' do
      let(:url) { "#{base_url}/users" }
      let(:current_user) { create(:user) }
      let!(:users) { create_list(:user, 20) }

      it 'returns the last page of users' do
        get url, headers: login_as(current_user), params: { page: 6 }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /users/:id' do
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:user) { create(:user) }
    let(:url) { "#{base_url}/users/#{user.id}" }
    let(:other_user) { create(:user) }
    let(:other_url) { "#{base_url}/users/#{user.id}" }

    context 'verify authorization' do
      it 'return 401 status if user is not logged in' do
        get url
        expect(response).to custom_have_http_status(401)
      end
    end

    it 'assigns the requested user to @user' do
      get url, headers: login_as(current_user)
      expect(assigns(:user)).to match_array([user])
    end
  end

  # describe 'GET /update' do
  #   it 'returns http success' do
  #     get '/users/update'
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET /create' do
  #   it 'returns http success' do
  #     get '/users/create'
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET /delete' do
  #   it 'returns http success' do
  #     get '/users/delete'
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end

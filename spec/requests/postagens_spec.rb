require 'rails_helper'

RSpec.describe 'Postagens', type: :request do
  describe 'GET /index' do
    context 'with no pagination params' do
      let(:url) { "#{base_url}/postagens" }
      let(:current_user) { create(:user) }
      let!(:postagens) { create_list(:postagem, 20) }

      it 'returns the first page of postagens' do
        get url, headers: login_as(current_user)
        expect(response).to custom_have_http_status(200)
      end
    end

    context 'with pagination params exceeding total pages' do
      let(:url) { "#{base_url}/postagens" }
      let(:current_user) { create(:user) }
      let!(:postagens) { create_list(:postagem, 20) }

      it 'returns the last page of postagens' do
        get url, headers: login_as(current_user), params: { page: 6 }
        expect(JSON.parse(response.body)['total_pages']).to eq(4)
        expect(response).to have_http_status(200)
      end
    end
  end

  # describe 'GET /show' do
  #   it 'returns http success' do
  #     get '/postagens/show'
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET /create' do
  #   it 'returns http success' do
  #     get '/postagens/create'
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET /update' do
  #   it 'returns http success' do
  #     get '/postagens/update'
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET /delete' do
  #   it 'returns http success' do
  #     get '/postagens/delete'
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end

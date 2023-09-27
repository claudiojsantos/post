require 'rails_helper'

RSpec.describe 'Comentarios', type: :request do
  describe 'GET /comentarios' do
    context 'verify authorization' do
      let(:url) { "#{base_url}/comentarios" }

      it 'return 401 status if user is not logged in' do
        get url
        expect(response).to custom_have_http_status(401)
      end
    end

    context 'with no pagination params' do
      let(:url) { "#{base_url}/comentarios" }
      let(:current_user) { create(:user) }
      let!(:postagens) { create_list(:comentario, 20) }

      it 'returns the first page of comentarios' do
        get url, headers: login_as(current_user)
        expect(response).to custom_have_http_status(200)
      end
    end

    context 'with pagination params exceeding total pages' do
      let(:url) { "#{base_url}/comentarios" }
      let(:current_user) { create(:user) }
      let!(:postagens) { create_list(:comentario, 20) }

      it 'returns the last page of comentarios' do
        get url, headers: login_as(current_user), params: { page: 6 }
        expect(response).to have_http_status(200)
      end
    end
  end

  # describe "GET /show" do
  #   it "returns http success" do
  #     get "/comentarios/show"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /update" do
  #   it "returns http success" do
  #     get "/comentarios/update"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /create" do
  #   it "returns http success" do
  #     get "/comentarios/create"
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end

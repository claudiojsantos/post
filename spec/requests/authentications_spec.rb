require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  describe 'POST /login' do
    let(:url) { "#{base_url}/login" }
    let!(:current_user) { create(:user, password: '12345678') }
    let(:valid_credentials) { { email: current_user.email, password: current_user.password } }
    let(:invalid_credentials) { { email: current_user.email, password: 'wrong' } }

    context 'with valid credentials' do
      before { post url, headers: login_as(current_user), params: valid_credentials.to_json }

      it 'returns http success' do
        expect(response).to custom_have_http_status(200)
      end

      it 'returns a token' do
        json_response = JSON.parse(response.body)
        expect(json_response['token']).not_to be_nil
      end
    end

    context 'with invalid credentials' do
      before { post url, headers: login_as(current_user), params: invalid_credentials.to_json }

      it 'return unauthorizes status' do
        expect(response).to custom_have_http_status(401)
      end

      it 'does not return a token' do
        json_response = JSON.parse(response.body)
        expect(json_response['token']).to be_nil
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Credenciais Inválidas')
      end
    end
  end
end

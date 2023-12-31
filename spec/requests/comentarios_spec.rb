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

  describe 'GET /comentarios/:id' do
    let(:current_user) { create(:user) }
    let!(:comentario) { create(:comentario) }
    let(:url) { "#{base_url}/comentarios/#{comentario.id}" }

    context 'verify authorization' do
      it 'return 401 status if user is not logged in' do
        get url
        expect(response).to custom_have_http_status(401)
      end
    end

    it 'assigns the requested postagem to @comentario' do
      get url, headers: login_as(current_user)
      expect(assigns(:comentario)).to match_array([comentario])
    end
  end

  describe 'GET /create' do
    let(:url) { "#{base_url}/comentarios" }
    let(:current_user) { create(:user) }
    let(:postagem) { create(:postagem) }
    let(:valid_attributes) { attributes_for(:comentario, postagem_id: postagem.id) }

    context 'with valid attributes' do
      it 'creates a new comentario' do
        expect do
          post url, headers: without_login, params: { comentario: valid_attributes }.to_json
        end.to change(Comentario, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:url) { "#{base_url}/comentarios" }
      let(:current_user) { create(:user) }
      let(:invalid_attributes) { { nome: '', comentario: '' } }

      it 'does not save the new comentario' do
        expect do
          post url, headers: without_login, params: { comentario: invalid_attributes }.to_json
        end.not_to change(Comentario, :count)
      end
    end
  end
end

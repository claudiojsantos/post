require 'rails_helper'

RSpec.describe 'Postagens', type: :request do
  describe 'GET /postagens' do
    context 'verify authorization' do
      let(:url) { "#{base_url}/postagens" }

      it 'return 401 status if user is not logged in' do
        get url
        expect(response).to custom_have_http_status(401)
      end
    end

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
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PUT /postagens/:id' do
    let!(:postagem) { create(:postagem) }
    let(:current_user) { create(:user) }

    context 'verify authorization' do
      let(:params) { { id: postagem.id, postagem: { titulo: 'Novo Titulo' } } }
      let(:url) { "#{base_url}/postagens/#{params[:id]}" }

      it 'return 401 status if user is not logged in' do
        put url
        expect(response).to custom_have_http_status(401)
      end
    end

    context 'when the post is successfully updated' do
      let(:params) { { id: postagem.id, postagem: { titulo: 'Novo Titulo' } } }
      let(:url) { "#{base_url}/postagens/#{params[:id]}" }
      let(:params_body) { { postagem: params[:postagem] }.to_json }

      it 'returns a success response' do
        put url, headers: login_as(current_user), params: params_body
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Postagem Atualizada')
      end
    end

    context 'when the post is not found' do
      let(:params) { { id: -1, postagem: { titulo: 'Novo Titulo' } } }
      let(:url) { "#{base_url}/postagens/#{params[:id]}" }
      let(:params_body) { { postagem: params[:postagem] }.to_json }

      it 'returns an error response' do
        put url, headers: login_as(current_user), params: params_body
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end

    context 'when parameters are invalid' do
      let(:params) { { id: postagem.id, postagem: { titulo: '' } } }
      let(:url) { "#{base_url}/postagens/#{params[:id]}" }
      let(:params_body) { { postagem: params[:postagem] }.to_json }

      it 'returns an error response' do
        put url, headers: login_as(current_user), params: params_body
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe 'GET /postagens/:id' do
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:postagem) { create(:postagem, user: current_user) }
    let(:url) { "#{base_url}/postagens/#{postagem.id}" }
    let(:other_user_postagem) { create(:postagem, user: other_user) }
    let(:other_url) { "#{base_url}/postagens/#{postagem.id}" }

    context 'verify authorization' do
      it 'return 401 status if user is not logged in' do
        get url
        expect(response).to custom_have_http_status(401)
      end
    end

    it 'assigns the requested postagem to @postagem' do
      get url, headers: login_as(current_user)
      expect(assigns(:postagem)).to match_array([postagem])
    end

    it 'filters postagems by diferents user_id and id' do
      get other_url, headers: login_as(other_user)
      expect(assigns(:postagem)).to be_empty
    end
  end

  describe 'POST /postagens' do
    let(:url) { "#{base_url}/postagens" }
    let(:current_user) { create(:user) }

    context 'verify authorization' do
      it 'return 401 status if user is not logged in' do
        post url
        expect(response).to custom_have_http_status(401)
      end
    end

    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:postagem) }

      it 'creates a new postagem' do
        expect do
          post url, headers: login_as(current_user), params: { postagem: valid_attributes }.to_json
        end.to change(Postagem, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:url) { "#{base_url}/postagens" }
      let(:current_user) { create(:user) }
      let(:invalid_attributes) { { title: '', content: '' } }

      it 'does not save the new postagem' do
        expect do
          post url, headers: login_as(current_user), params: { postagem: invalid_attributes }.to_json
        end.not_to change(Postagem, :count)
      end
    end
  end

  describe 'DELETE /postagens/:id' do
    let(:current_user) { create(:user) }
    let!(:postagem) { create(:postagem, user: current_user) }
    let(:url) { "#{base_url}/postagens/#{postagem.id}" }

    it 'deletes the postagem' do
      expect do
        delete url, headers: login_as(current_user)
      end.to change(Postagem, :count).by(-1)
    end

    context 'verify authorization' do
      it 'return 401 status if user is not logged in' do
        delete url
        expect(response).to custom_have_http_status(401)
      end
    end
  end
end

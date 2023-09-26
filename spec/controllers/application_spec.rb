require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }
  let(:token) { ApplicationController.new.encode_token(user_id: user.id) }

  describe '#auth_header' do
    it 'returns Authorization header from the request' do
      request.headers['Authorization'] = token
      expect(controller.send(:auth_header)).to eq token
    end
  end

  describe '#decoded_token' do
    context 'with valid auth header' do
      before { request.headers['Authorization'] = "Bearer #{token}" }

      it 'decodes the token' do
        expect(controller.send(:decoded_token)).to be_a(Hash)
        expect(controller.send(:decoded_token)['user_id']).to eq(user.id)
      end
    end

    context 'with an invalid token' do
      let(:invalid_token) { 'invalid_token' }

      before do
        request.headers['Authorization'] = "Bearer #{invalid_token}"
        allow(JsonWebToken).to receive(:jwt_decode).and_raise(CustomError::InvalidToken)
      end

      it 'rescues from CustomError::InvalidToken and returns nil' do
        expect(controller.send(:decoded_token)).to be_nil
      end
    end

    context 'when auth header is not present' do
      it 'returns nil' do
        expect(controller.send(:decoded_token)).to be_nil
      end
    end
  end

  describe '#current_user' do
    context 'when decoded token is valid' do
      before { allow(controller).to receive(:decoded_token).and_return([{ 'user_id' => user.id }]) }

      it 'finds the user' do
        expect(controller.send(:current_user)).to eq user
      end
    end

    context 'when decoded token is not valid' do
      before { allow(controller).to receive(:decoded_token).and_return(nil) }

      it 'returns nil' do
        expect(controller.send(:current_user)).to be_nil
      end
    end
  end

  describe '#logged_in?' do
    context 'with a current user' do
      before { allow(controller).to receive(:current_user).and_return(user) }

      it 'returns true' do
        expect(controller.send(:logged_in?)).to be_truthy
      end
    end

    context 'without a current user' do
      before { allow(controller).to receive(:current_user).and_return(nil) }

      it 'returns false' do
        expect(controller.send(:logged_in?)).to be_falsey
      end
    end
  end

  describe '#authorized' do
    context 'when user is logged in' do
      before { allow(controller).to receive(:logged_in?).and_return(true) }

      it 'does not raise an error' do
        expect { controller.send(:authorized) }.not_to raise_error
      end
    end
  end
end

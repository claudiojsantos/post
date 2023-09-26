require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:user_id) { 1 }
  let(:payload) { { user_id: user_id } }
  
  describe '.jwt_encode' do
    it 'encodes a payload into a JWT token' do
      token = described_class.jwt_encode(payload)
      decoded_payload = JWT.decode(token, JsonWebToken::SECRET_KEY, true, { algorithm: 'HS256' })[0]

      expect(decoded_payload['user_id']).to eq(user_id)
    end
  end

  describe '.jwt_decode' do
    context 'with a valid token' do
      let(:token) { described_class.jwt_encode(payload) }

      it 'decodes a JWT token' do
        decoded_payload = described_class.jwt_decode(token)
        expect(decoded_payload[:user_id]).to eq(user_id)
      end
    end

    context 'with an invalid token' do
      let(:invalid_token) { 'invalid_token' }

      it 'raises CustomError::InvalidToken error' do
        expect { described_class.jwt_decode(invalid_token) }.to raise_error(CustomError::InvalidToken, 'Token Inválido')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Postagem::UpdateService do
  describe '#call' do
    let!(:postagem) { create(:postagem) }
    let(:params) { { 'titulo' => 'Novo Título' } }
    subject { described_class.new(postagem, params) }

    context 'when a postagem is exists' do
      it 'updates the postagem with the new params' do
        expect(subject.call).to be_truthy
        expect(postagem.reload.titulo).to eq('Novo Título')
      end
    end

    context 'when a postagem is not exist' do
      let!(:postagem) { nil }
      let(:params) { { 'titulo' => 'Novo Título' } }
      subject { described_class.new(postagem, params) }

      it 'returns false' do
        expect(subject.call).to be_falsey
      end

      it 'without errors' do
        subject.call
        expect(subject.errors).to be_empty
      end
    end

    context 'when a postagem fails to update' do
      let(:params) { { 'titulo' => '' } }

      it 'returns false' do
        expect(subject.call).to be_falsey
      end

      it 'with errors' do
        subject.call
        expect(subject.errors).not_to be_empty
      end
    end
  end
end

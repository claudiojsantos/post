require 'rails_helper'

RSpec.describe Comentario, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:nome) }
    it { should validate_length_of(:nome).is_at_least(5) }
    it { should validate_presence_of(:comentario) }
    it { should validate_length_of(:comentario).is_at_least(10) }
  end

  describe 'associations' do
    it { should belong_to(:postagem) }
  end
end

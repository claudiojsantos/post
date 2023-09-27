require 'rails_helper'

RSpec.describe Postagem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:titulo) }
    it { should validate_length_of(:titulo).is_at_least(5) }
    it { should validate_presence_of(:texto) }
    it { should validate_length_of(:texto).is_at_least(10) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comentarios).dependent(:destroy) }
  end
end

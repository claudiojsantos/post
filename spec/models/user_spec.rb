require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }

    it { should have_many(:postagens).dependent(:destroy) }
    it { should have_many(:comentarios).through(:postagens) }
  end

  describe 'other validations' do
    context 'when name is not present' do
      let(:user) { build(:user, name: nil) }

      it 'is not valid' do
        expect(user).not_to be_valid
        expect(user.errors[:name]).to include("can't be blank")
      end
    end

    context 'when email is duplicated' do
      let(:user) { create(:user) }
      let(:user2) { build(:user, email: user.email) }

      it 'is not valid' do
        expect(user2).not_to be_valid
        expect(user2.errors[:email]).to include('has already been taken')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:blogs) }
  end

  describe '#authenticate' do
    let(:user) { create(:user, password: 'password') }

    it 'returns true when the password is correct' do
      expect(user.authenticate('password')).to eq(true)
    end

    it 'returns false when the password is incorrect' do
      expect(user.authenticate('wrong_password')).to eq(false)
    end
  end

  describe '#encrypt_password' do
    let(:user) { build(:user, password: 'password') }

    it 'encrypts the password before saving' do
      user.save
      expect(user.password).not_to eq('password')
    end
  end
end

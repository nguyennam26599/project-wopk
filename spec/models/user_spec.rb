# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is database authenticable' do
    user = User.create(
      email: 'test@gmail.com',
      password: 'pass123',
      password_confirmation: 'pass123'
    )
    expect(user.valid_password?('pass123')).to be true
  end

  it 'has many post' do
    should respond_to(:posts)
  end

  it 'has many comment' do
    should respond_to(:comments)
  end

  subject { described_class.new(password: 'pass123', name: 'Anh', email: 'anh@gmail.com') }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a mail' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end
  end
end

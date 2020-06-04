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

  it 'return a full name user created post' do
    user = User.create(first_name: 'Hoang', last_name: 'Anh')
    expect(user.full_name == 'Hoang Anh').to be true
  end

  subject { described_class.new(password: 'pass123', name: 'Anh', email: 'anh@gmail.com') }

  describe 'Validations' do
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

    it 'it should require a username' do
      user = User.create(name: '')
      expect(user.errors[:name]).to be_present
    end

    it 'is invalid with a duplicate name' do
      User.create!(
        name: 'HoangAnh',
        email: 'test1@example.com',
        password: '123456'
      )
      user2 = User.new(
        name: 'HoangAnh',
        email: 'test2@example.com',
        password: '123456'
      )
      user2.valid?
      expect(user2.errors[:name]).to include('has already been taken')
    end

    it 'is valid with a name regex' do
      subject.name = 'hoanganh123'
      expect(subject).to be_valid
    end

    it 'is not valid without a name regex' do
      subject.name = 'hoanganh 123'
      expect(subject).to_not be_valid
    end
  end

  it 'is return fullname' do
    u = User.create(first_name: 'Vi', last_name: 'Hoang')
    expect("#{u.first_name} #{u.last_name}" == 'Vi Hoang').to be true
  end

  it 'is return link github' do
    u = User.create(github_link: 'e23w')
    expect(u.link_github == 'http://github.com/e23w').to be true
  end

  it 'is return link facebook' do
    u = User.create(facebook_link: 'e23w')
    expect(u.link_facebook == 'http://facebook.com/e23w').to be true
  end

  it 'is return linkedin' do
    u = User.create(linkedln_link: 'e23w')
    expect(u.link_linkedin == 'https://www.linkedin.com/e23w').to be true
  end

  it 'is return link url' do
    u = User.create(url_link: 'blogtruyen.com')
    expect(u.link_url == 'http://blogtruyen.com').to be true
  end

  it 'is return fullname' do
    u = User.create(first_name: 'Vi', last_name: 'Hoang')
    expect("#{u.first_name} #{u.last_name}" == 'Vi Hoang').to be true
  end

  it 'is return link github' do
    u = User.create(github_link: 'e23w')
    expect(u.link_github == 'http://github.com/e23w').to be true
  end

  it 'is return link facebook' do
    u = User.create(facebook_link: 'e23w')
    expect(u.link_facebook == 'http://facebook.com/e23w').to be true
  end

  it 'is return linkedin' do
    u = User.create(linkedln_link: 'e23w')
    expect(u.link_linkedin == 'https://www.linkedin.com/e23w').to be true
  end

  it 'is return link url' do
    u = User.create(url_link: 'blogtruyen.com')
    expect(u.link_url == 'http://blogtruyen.com').to be true
  end

  it 'is return fullname' do
    u = User.create(first_name: 'Vi', last_name: 'Hoang')
    expect("#{u.first_name} #{u.last_name}" == 'Vi Hoang').to be true
  end

  it 'is return link github' do
    u = User.create(github_link: 'e23w')
    expect(u.link_github == 'http://github.com/e23w').to be true
  end

  it 'is return link facebook' do
    u = User.create(facebook_link: 'e23w')
    expect(u.link_facebook == 'http://facebook.com/e23w').to be true
  end

  it 'is return linkedin' do
    u = User.create(linkedln_link: 'e23w')
    expect(u.link_linkedin == 'https://www.linkedin.com/e23w').to be true
  end

  it 'is return link url' do
    u = User.create(url_link: 'blogtruyen.com')
    expect(u.link_url == 'http://blogtruyen.com').to be true
  end

  it 'is return full name' do
    u = User.create(first_name: 'Vi', last_name: 'Hoang')
    expect(u.full_name == 'Vi Hoang').to be true
  end

  it 'is return link github' do
    u = User.create(github_link: 'e23w')
    expect(u.link_github == 'http://github.com/e23w').to be true
  end

  it 'is return link facebook' do
    u = User.create(facebook_link: 'e23w')
    expect(u.link_facebook == 'http://facebook.com/e23w').to be true
  end

  it 'is return linkedin' do
    u = User.create(linkedln_link: 'e23w')
    expect(u.link_linkedin == 'https://www.linkedin.com/e23w').to be true
  end

  it 'is return link url' do
    u = User.create(url_link: 'blogtruyen.com')
    expect(u.link_url == 'http://blogtruyen.com').to be true
  end
end

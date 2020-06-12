# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it 'has many tags' do
      should respond_to(:tags)
    end
    it 'has many comment' do
      should respond_to(:comments)
    end
    it 'has many post_voting' do
      should respond_to(:post_votings)
    end
  end
  subject { described_class.new(vote: 100, view_count: 1000) }
  it 'return a vote count' do
    expect(subject.vote_count == '+100').to be true
  end
  it 'return a view count' do
    expect(subject.view_count == 1000).to be true
  end

  describe 'scopes' do
    before do
      @post2 = Post.create(
        title: 'test1',
        user_id: 1
      )
      @user1 = User.create(
        name: 'hoangvv',
        email: 'test1234@gmail.com',
        password: '123456'
      )
    end
    it 'orders by ascending create_at' do
      @post1 = Post.create(
        title: 'test2',
        user_id: 1
      )
      Post.sort_new_post == [@post1, @post2]
    end
    it 'orders by ascending count view' do
      @post1 = Post.create(
        title: 'test2',
        user_id: 1,
        view_count: '3123'
      )
      Post.sort_trend_post == [@post1, @post2]
    end
    it 'orders by ascending count view monthly' do
      @post1 = Post.create(
        title: 'test2',
        user_id: 1,
        view_count: '3123'
      )
      Post.top_post_public_this_month == [@post1, @post2]
    end
    it 'not post monthly' do
      @post1 = Post.create(
        title: 'test2',
        user_id: 1,
        view_count: '3123',
        created_at: '2020-05-10 08:50:38'
      )
      Post.top_post_public_this_month == [@post2]
    end
  end
end

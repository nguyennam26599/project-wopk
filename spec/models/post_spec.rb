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
  end
  subject { described_class.new(vote: 100, view_count: 1000) }
  it 'return a vote count' do
    expect(subject.vote_count == '+100').to be true
  end
  it 'return a view count' do
    expect(subject.view_count == 1000).to be true
  end
end

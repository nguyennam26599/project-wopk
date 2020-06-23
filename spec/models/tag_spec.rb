# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'Associations' do
    it 'has many users follower' do
      should respond_to(:followers)
    end
    it 'has many post' do
      should respond_to(:posts)
    end
  end

  context 'Validations' do
    it 'is not valid without a name' do
      subject.name = 'acc'
      expect(subject).to be_valid
    end
  end

  context 'Search' do
    it 'returns tag that match the search name and status' do
      tag = create(:tag)
      expect(Tag.search_name_status_public(tag.name)).to include(tag)
    end
  end

  it 'return a follower size' do
    user = create(:user)
    tag = create(:tag)
    FollowPolymorphic.create(follower: user, following: tag)
    expect(tag.tag_follower_size == 1).to be true
  end

  it 'return a post size' do
    tag = create(:tag)
    post = create(:post)
    PostsRelationship.create(posts_relationship: tag, post_id: post.id)
    expect(tag.tag_post_size == 1).to be true
  end
end

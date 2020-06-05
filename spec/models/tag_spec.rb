# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  def create_user
    User.create(email: 'abcde@test.vn', name: 'tagtest1', password: '123456')
  end

  def create_post
    user = create_user
    Post.create(title: 'post 1', user_id: user.id)
  end

  def create_tag
    Tag.create(name: 'tag 1')
  end

  it 'returns tag that match the search name and status' do
    tag2 = Tag.create(
      name: 'This is the second tag.',
      status: 'publish'
    )
    expect(Tag.search_name_status_public('This')).to include(tag2)
  end

  describe 'Associations' do
    it 'has many users follower' do
      should respond_to(:followers)
    end
  end
  it 'return a follower size' do
    user = create_user
    tag = create_tag
    FollowPolymorphic.create(follower: user, following: tag)
    expect(tag.tag_follower_size == 1).to be true
  end
  it 'return a post size' do
    tag = create_tag
    post = create_post
    PostsRelationship.create(posts_relationship: tag, post_id: post.id)
    expect(tag.tag_post_size == 1).to be true
  end
end

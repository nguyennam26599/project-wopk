# frozen_string_literal: true

class FollowPolymorphic < ApplicationRecord
  belongs_to :following, polymorphic: true
  belongs_to :follower, polymorphic: true

  def self.user_follow_post(user, post)
    find_by(follower: user, following: post)
  end

  def self.create_follow_post(user, post)
    create(follower: user, following: post)
  end
end

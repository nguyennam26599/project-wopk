# frozen_string_literal: true

class FollowPolymorphic < ApplicationRecord
  belongs_to :following, polymorphic: true
  belongs_to :follower, polymorphic: true
end

# frozen_string_literal: true

class PostsRelationship < ApplicationRecord
  belongs_to :posts
  belongs_to :posts_relationship, polymorphic: true
end

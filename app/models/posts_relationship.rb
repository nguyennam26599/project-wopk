# frozen_string_literal: true

class PostsRelationship < ApplicationRecord
  belongs_to :post
  belongs_to :posts_relationship, polymorphic: true
end

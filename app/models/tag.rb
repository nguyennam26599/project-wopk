# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :posts_relationships, as: :posts_relationship
  has_many :posts, through: :posts_relationships
end

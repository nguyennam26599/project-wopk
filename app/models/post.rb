# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments
  has_many :posts_relationships
  belongs_to :user
end

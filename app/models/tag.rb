# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :posts, as: :posts_relationship
end

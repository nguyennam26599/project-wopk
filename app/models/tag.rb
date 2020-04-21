# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :posts_relationship, as: :posts_relationship
end

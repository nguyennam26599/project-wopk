# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :posts_relationship, as: :posts_relationship
end

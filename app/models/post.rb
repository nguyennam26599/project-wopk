# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments
  has_many :posts_relationships
  has_many :tags, through: :posts_relationships, source: :posts_relationship, source_type: 'Tag'
  belongs_to :user

  def vote_count
    if vote.positive?
      "+#{vote}"
    elsif vote.negative?
      vote.to_s
    else
      '0'
    end
  end
end
